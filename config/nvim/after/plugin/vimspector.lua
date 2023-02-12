local session_is_active = function()
  return vim.fn.exists("g:vimspector_session_active") == 1
end

local keymap_exists = function(mode, key)
  local keymaps = vim.api.nvim_get_keymap(mode)
  for _, map in ipairs(keymaps) do
    if map[1] == key then
      return true
    end
  end
  return false
end

local keymap = function()
  if not session_is_active() then
    if keymap_exists("n", "<F6>") then vim.api.nvim_del_keymap("n", "<F6>") end
    if keymap_exists("n", "<C-S-I>") then vim.keymap.del("n", "<C-S-I>") end
    if keymap_exists("n", "<C-F8>") then vim.keymap.del("n", "<C-F8>") end
  else
    vim.api.nvim_set_keymap("n", "<F5>", "<cmd>call vimspector#StepInto()<cr>", {noremap = true})
    vim.api.nvim_set_keymap("n", "<F6>", "<cmd>call vimspector#StepOver()<cr>", {noremap = true})
    vim.api.nvim_set_keymap("n", "<F7>", "<cmd>call vimspector#StepOut()<cr>", {noremap = true})
    vim.api.nvim_set_keymap("n", "<F8>", "<cmd>call vimspector#Continue()<cr>", {noremap = true})
    if keymap_exists("n", "<F9>") then vim.keymap.del("n", "<F9>") end
    if keymap_exists("n", "<F12>") then vim.keymap.set("n", "<F12>", "<cmd>call vimspector#Reset()<cr>") end
    if keymap_exists("n", "<C-S-I>") then vim.keymap.set("n", "<C-S-I>", "<cmd>call vimspector#AddWatch()<cr>") end
    if keymap_exists("n", "<C-F8>") then vim.keymap.set("n", "<C-F8>", "<cmd>call vimspector#Evaluate()<cr>") end
  end
end

vim.keymap.set("n", "<F11>", "<cmd>call vimspector#Launch()<cr>")
vim.keymap.set("n", "<C-S-B>", "<cmd>call vimspector#ToggleBreakpoint()<cr>")

vim.schedule(keymap)
