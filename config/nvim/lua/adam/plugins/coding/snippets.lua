local utils = require 'adam.utils'

return {
  -- disable builtin snippet support
  { 'garymjr/nvim-snippets', enabled = false },

  {
    'L3MON4D3/LuaSnip',
    version = '2.3.0',
    lazy = true,
    build = (not utils.is_win()) and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp" or nil,
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets' } }
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
  },

  {
    'L3MON4D3/LuaSnip',
    opts = function()
      utils.cmp.actions.snippet_forward = function()
        if require('luasnip').jumpable(1) then
          require('luasnip').jump(1)
          return true
        end
      end
      utils.cmp.actions.snippet_stop = function()
        if require('luasnip').expand_or_jumpable() then -- or just jumpable(1) is fine?
          require('luasnip').unlink_current()
          return true
        end
      end
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'saadparwaiz1/cmp_luasnip' },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      }
      table.insert(opts.sources, { name = 'luasnip' })
    end,
    -- stylua: ignore
    keys = {
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
}
