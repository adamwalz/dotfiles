local vimspector_session_is_active = function()
  return vim.fn.exists("g:vimspector_session_active") == 1
end

local keymap = function()
  if not vimspector_session_is_active() then
    vim.api.nvim_set_keymap("", "<F5>", ":setlocal spell! spelllang=en_us<CR>", {noremap = true})
  end
end

vim.schedule(keymap)
