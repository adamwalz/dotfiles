local undo_tree_available, _ = pcall(require, "undotree")

if undo_tree_available then
  vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end
