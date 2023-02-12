-- disable netrw at the very start of your init.lua (strongly advised when using nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.fn.setenv("PATH",
  "/Users/adamwalz/.local/share/nvim/mason/bin"
  ..":/Users/adamwalz/.tilde/bin"
  ..":/Users/adamwalz/.cargo/bin"
  ..":/opt/homebrew/bin"
  ..":/opt/homebrew/sbin"
  ..":/usr/bin"
  ..":/bin"
  ..":/usr/sbin"
  ..":/sbin"
)

require("adamwalz")
