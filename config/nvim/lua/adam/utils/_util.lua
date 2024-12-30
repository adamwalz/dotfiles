local M = {}

local warn = require('lazy.core.util').warn

local CREATE_UNDO = vim.api.nvim_replace_termcodes('<c-G>u', true, true, true)

function M.create_undo()
  if vim.api.nvim_get_mode().mode == 'i' then
    vim.api.nvim_feedkeys(CREATE_UNDO, 'n', false)
  end
end

function M.is_win()
  return vim.uv.os_uname().sysname:find 'Windows' ~= nil
end

function M.extend_or_override(config, custom, ...)
  if type(custom) == 'function' then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend('force', config, custom) --[[@as table]]
  end
  return config
end

function M.get_pkg_path(pkg, path, opts)
  pcall(require, 'mason') -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath 'data' .. '/mason')
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ''
  local ret = root .. '/packages/' .. pkg .. '/' .. path
  if opts.warn and not vim.loop.fs_stat(ret) and not require('lazy.core.config').headless() then
    warn(('Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package.'):format(pkg, path))
  end
  return ret
end

function M.get_root_dir()
  local root_patterns = { '.git', 'lua' }
  local path = vim.fn.expand '%:p:h'
  local root = vim.fs.find(root_patterns, {
    path = path,
    upward = true,
  })[1]
  return root and vim.fs.dirname(root) or vim.fn.getcwd()
end

function M.get_pretty_path()
  local filename = vim.fn.expand '%:t'
  local filepath = vim.fn.expand '%:p:h'
  local relative = vim.fn.fnamemodify(filepath, ':~:.')
  return (relative == '.' and '' or relative .. '/') .. filename
end

function M.dedup(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end,
  })
end

function M.is_loaded(name)
  local Config = require 'lazy.core.config'
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M
