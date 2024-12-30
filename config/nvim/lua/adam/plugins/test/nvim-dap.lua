return {
  'mfussenegger/nvim-dap',
  -- stylua: ignore
  keys = {
    { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
  },
}
