local M = {}

local _util = require 'adam.utils._util'

function M.confirm(opts)
  local cmp = require 'cmp'
  opts = vim.tbl_extend('force', {
    select = true,
    behavior = cmp.ConfirmBehavior.Insert,
  }, opts or {})
  return function(fallback)
    if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
      _util.create_undo()
      if cmp.confirm(opts) then
        return
      end
    end
    return fallback()
  end
end

M.actions = {
  -- Native Snippets
  snippet_forward = function()
    if vim.snippet.active({ direction = 1 }) then
      vim.schedule(function()
        vim.snippet.jump(1)
      end)
      return true
    end
  end,
  snippet_stop = function()
    if vim.snippet then
      vim.snippet.stop()
    end
  end,
}

function M.map(mapped_actions, fallback)
  return function()
    for _, name in ipairs(mapped_actions) do
      if M.actions[name] then
        local ret = M.actions[name]()
        if ret then
          return true
        end
      end
    end
    return type(fallback) == 'function' and fallback() or fallback
  end
end

function M.auto_brackets(entry)
  local cmp = require 'cmp'
  local Kind = cmp.lsp.CompletionItemKind
  local item = entry:get_completion_item()
  if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
    local cursor = vim.api.nvim_win_get_cursor(0)
    local prev_char = vim.api.nvim_buf_get_text(0, cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] + 1, {})[1]
    if prev_char ~= '(' and prev_char ~= ')' then
      local keys = vim.api.nvim_replace_termcodes('()<left>', false, false, true)
      vim.api.nvim_feedkeys(keys, 'i', true)
    end
  end
end

function M.snippet_preview(snippet)
  local ok, parsed = pcall(function()
    return vim.lsp._snippet_grammar.parse(snippet)
  end)
  return ok and tostring(parsed) or M.snippet_replace(snippet, function(placeholder)
    return M.snippet_preview(placeholder.text)
  end):gsub('%$0', '')
end

function M.add_missing_snippet_docs(window)
  local cmp = require 'cmp'
  local Kind = cmp.lsp.CompletionItemKind
  local entries = window:get_entries()
  for _, entry in ipairs(entries) do
    if entry:get_kind() == Kind.Snippet then
      local item = entry:get_completion_item()
      if not item.documentation and item.insertText then
        item.documentation = {
          kind = cmp.lsp.MarkupKind.Markdown,
          value = string.format('```%s\n%s\n```', vim.bo.filetype, M.snippet_preview(item.insertText)),
        }
      end
    end
  end
end

function M.setup(opts)
  for _, source in ipairs(opts.sources) do
    source.group_index = source.group_index or 1
  end

  local parse = require('cmp.utils.snippet').parse
  require('cmp.utils.snippet').parse = function(input)
    local ok, ret = pcall(parse, input)
    if ok then
      return ret
    end
    return M.snippet_preview(input)
  end

  local cmp = require 'cmp'
  cmp.setup(opts)
  cmp.event:on('confirm_done', function(event)
    if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
      M.auto_brackets(event.entry)
    end
  end)
  cmp.event:on('menu_opened', function(event)
    M.add_missing_snippet_docs(event.window)
  end)
end

return M
