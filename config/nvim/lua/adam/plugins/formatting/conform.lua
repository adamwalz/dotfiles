local utils = require 'adam.utils'

local warn = require('lazy.core.util').warn
local error = require('lazy.core.util').error

local M = {}

function M.setup(_, opts)
  for _, key in ipairs { 'format_on_save', 'format_after_save' } do
    if opts[key] then
      local msg = "Don't set `opts.%s` for `conform.nvim`.\n**LazyVim** will use the conform formatter automatically"
      warn(msg:format(key))
      ---@diagnostic disable-next-line: no-unknown
      opts[key] = nil
    end
  end
  ---@diagnostic disable-next-line: undefined-field
  if opts.format then
    warn '**conform.nvim** `opts.format` is deprecated. Please use `opts.default_format_opts` instead.'
  end
  require('conform').setup(opts)
end

return {
  'stevearc/conform.nvim',
  version = '8.2.0',
  dependencies = { 'mason.nvim' },
  lazy = true,
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>cF',
      function()
        require('conform').format { formatters = { 'injected' }, timeout_ms = 3000 }
      end,
      mode = { 'n', 'v' },
      desc = 'Format Injected Langs',
    },
  },
  init = function()
    -- Install the conform formatter on VeryLazy
    utils.on_very_lazy(function()
      utils.format.register {
        name = 'conform.nvim',
        priority = 100,
        primary = true,
        format = function(buf)
          require('conform').format { bufnr = buf }
        end,
        sources = function(buf)
          local ret = require('conform').list_formatters(buf)
          ---@param v conform.FormatterInfo
          return vim.tbl_map(function(v)
            return v.name
          end, ret)
        end,
      }
    end)
  end,
  opts = function()
    local plugin = require('lazy.core.config').plugins['conform.nvim']
    if plugin.config ~= M.setup then
      error({
        "Don't set `plugin.config` for `conform.nvim`.\n",
        'This will break **LazyVim** formatting.\n',
        'Please refer to the docs at https://www.lazyvim.org/plugins/formatting',
      }, { title = 'LazyVim' })
    end
    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = 'fallback', -- not recommended to change
      },
      formatters_by_ft = {},
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
      },
    }
    return opts
  end,
  config = M.setup,
}