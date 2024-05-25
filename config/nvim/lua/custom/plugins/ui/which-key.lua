return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    if LazyVim.has("noice.nvim") then
      opts.defaults["<leader>sn"] = { name = "+noice" }
    end
  end,
}
