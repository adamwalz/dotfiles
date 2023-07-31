local tree_available, tree = pcall(require, "nvim-tree")
if tree_available then
  local api = require("nvim-tree.api")
  tree.setup({
    sort_by = "case_sensitive",
    sync_root_with_cwd = true,
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = "u", action = "dir_up" },
        },
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })

  vim.keymap.set("n", "<C-n>", ":NvimTreeFocus<CR>")
  vim.keymap.set("n", "<C-S-n>", ":NvimTreeFindFileToggle<CR>")
  vim.keymap.set("n", "<leader>mn", api.marks.navigate.next)
  vim.keymap.set("n", "<leader>mp", api.marks.navigate.prev)
  vim.keymap.set("n", "<leader>ms", api.marks.navigate.select)
end
