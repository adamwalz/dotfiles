return {
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'ansible-lint' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ansiblels = {},
      },
    },
  },
  {
    'mfussenegger/nvim-ansible',
    commit = '44dabda',
    ft = {},
    keys = {
      {
        '<leader>ta',
        function()
          require('ansible').run()
        end,
        desc = 'Ansible Run Playbook/Role',
        silent = true,
      },
    },
  },
}
