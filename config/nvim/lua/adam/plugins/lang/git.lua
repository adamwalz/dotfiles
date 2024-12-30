return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'git_config', 'gitcommit', 'git_rebase', 'gitignore', 'gitattributes' } },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'petertriho/cmp-git',
        commit = 'ec04903',
        opts = {}
      },
    },
    ---@module 'cmp'
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = 'git' })
    end,
  },
}
