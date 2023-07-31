local lspzero_available, lsp = pcall(require, "lsp-zero")

if lspzero_available then

  lsp.preset('recommended')

  lsp.set_preferences({
    suggest_lsp_servers = true, -- sugges to download lsp servers when you enter a filetype for the first time
    setup_servers_on_start = true, -- all installed servers will be initialized on startup
    set_lsp_keymaps = false, -- add keybindings to a buffer with a language server attached
    configure_diagnostics = true, -- uses the built-in function vim.diagnostic.config to setup the way error messages are shown in the buffer
    cmp_capabilities = true, -- tell the language servers what capabilities nvim-cmp supports
    manage_nvim_cmp = true, -- use a custom setup for nvim-cmp
    call_servers = 'local', -- try to initialize servers that where installed using mason.nvim
    sign_icons = { -- shown in the "gutter" on the line diagnostics messages are located
      error = '✘',
      warn = '▲',
      hint = '⚑',
      info = ''
    }
  })

  -- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
  lsp.ensure_installed({
    'bashls',
    'cssls',
    'dockerls',
    'eslint',
    'golangci_lint_ls',
    'gradle_ls',
    'html',
    'jsonnet_ls',
    'puppet',
    'pyright',
    'rust_analyzer',
    'sqlls',
    'sumneko_lua',
    'terraformls',
    'texlab',
    'tsserver',
    'yamlls',
  })

  -- Fix Undefined global 'vim'
  lsp.configure('lua_ls', {
      settings = {
          Lua = {
              diagnostics = {
                  enable = true,
                  globals = { 'vim' }
              }
          }
      }
  })

  lsp.on_attach(function(client, bufnr)
    print('attaching to buffer')
    local opts = {buffer = bufnr, remap = false}

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  end)

  lsp.setup()

  vim.diagnostic.config({
      virtual_text = true,
  })
end
