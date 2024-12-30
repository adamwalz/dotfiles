local utils = require 'adam.utils'

return {
  {
    'nvimtools/none-ls.nvim',
    commit = '40dc2e9',
    event = 'LazyFile',
    dependencies = { 'mason.nvim' },
    init = function()
      utils.on_very_lazy(function()
        -- register the formatter with LazyVim
        utils.format.register {
          name = 'none-ls.nvim',
          priority = 200, -- set higher than conform, the builtin formatter
          primary = true,
          format = function(buf)
            return utils.lsp.format {
              bufnr = buf,
              filter = function(client)
                return client.name == 'null-ls'
              end,
            }
          end,
          sources = function(buf)
            local ret = require('null-ls.sources').get_available(vim.bo[buf].filetype, 'NULL_LS_FORMATTING') or {}
            return vim.tbl_map(function(source)
              return source.name
            end, ret)
          end,
        }
      end)
    end,
    opts = function(_, opts)
      local nls = require 'null-ls'
      opts.root_dir = opts.root_dir or require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git')
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
      })
    end,
  },
}
