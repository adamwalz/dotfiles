local zenmode_available, zenmode = pcall(require, "zen-mode")
if zenmode_available then
  zenmode.setup {
    window = {
      width = 90,
      options = {
        number = true,
        relativenumber = true,
      }
    },
  }

  vim.keymap.set("n", "<leader>zz", function()
    zenmode.toggle()
    vim.wo.wrap = false
    ColorMyPencils()
  end)
end
