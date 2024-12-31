return {
  'catppuccin/nvim',
  version = '1.9.0',
  lazy = true,
  name = 'catppuccin',
  opts = {
    integrations = {
      aerial = false,
      alpha = false,
      barbar = false,
      beacon = false,
      blink = false,
      cmp = true,
      coc_nvim = false,
      colorful_winsep = { enabled = false },
      dap = true,
      dap_ui = true,
      dashboard = false,
      diffview = false,
      dropbar = { enabled = false },
      fern = false,
      fidget = false,
      flash = true,
      fzf = false,
      gitsigns = true,
      grug_far = true,
      harpoon = false,
      headlines = false,
      hop = false,
      illuminate = false,
      indent_blankline = { enabled = false },
      leap = false,
      lightspeed = false,
      lir = { enabled = false },
      lsp_trouble = false,
      lsp_saga = false,
      mason = true,
      markdown = true,
      mini = {
        enabled = true,
        indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
        inlay_hints = {
          background = true,
        },
      },
      navic = { enabled = false, custom_bg = 'lualine' },
      neotest = true,
      neotree = true,
      neogit = false,
      noice = true,
      notify = false,
      NormalNvim = false,
      notifier = false,
      nvim_surround = false,
      nvimtree = false,
      copilot_vim = false,
      semantic_tokens = true,
      -- snacks = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      ts_rainbox2 = false,
      ts_rainbow = false,
      ufo = false,
      window_picker = false,
      octo = false,
      overseer = false,
      pounce = false,
      rainbow_delimiters = false,
      render_markdown = true,
      symbols_outline = false,
      telekasten = false,
      dadbod_ui = false,
      gitgutter = false,
      sandwich = false,
      vim_sneak = false,
      vimwiki = false,
      which_key = true,
    },
  },
  specs = {
    {
      'akinsho/bufferline.nvim',
      optional = true,
      opts = function(_, opts)
        if (vim.g.colors_name or ''):find 'catppuccin' then
          opts.highlights = require('catppuccin.groups.integrations.bufferline').get()
        end
      end,
    },
  },
}