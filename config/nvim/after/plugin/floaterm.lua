local vimspector_session_is_active = function()
  return vim.fn.exists("g:vimspector_session_active") == 1
end

local keymap = function()
  if not vimspector_session_is_active() then
    vim.api.nvim_set_keymap("n", "<F7>", ":FloatermNew<CR>", {noremap = true})
    vim.api.nvim_set_keymap("n", "<F8>", ":FloatermPrev<CR>", {noremap = true})
    vim.keymap.set("n", "<F9>", ":FloatermNext<CR>")
    vim.keymap.set("n", "<F12>", ":FloatermToggle<CR>")
  end
end

vim.api.nvim_set_keymap("t", "<F7>", "<C-\\><C-n>:FloatermNew<CR>", {noremap = true})
vim.api.nvim_set_keymap("t", "<F8>", "<C-\\><C-n>:FloatermPrev<CR>", {noremap = true})
vim.keymap.set("t", "<F9>", "<C-\\><C-n>:FloatermNext<CR>")
vim.keymap.set("t", "<F12>", "<C-\\><C-n>:FloatermToggle<CR>")

vim.schedule(keymap)
