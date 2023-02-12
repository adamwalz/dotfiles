local rosepine_available, rosepine = pcall(require, "rose-pine")
local monokai_available, monokai = pcall(require, "monokai")

local function setup_rose_pine()
  rosepine.setup({
    disable_background = true
  })
end

-- a comment
local function setup_monokai()
  local palette = {
    name = 'monokai',
    base1 = '#272a30',
    base2 = '#26292C', -- background
    base3 = '#2E323C', -- color column, cursor line
    base4 = '#5b5353', -- visual bg
    base5 = '#4d5154', -- non text, line numbers
    base6 = '#72696A', -- comments
    base7 = '#b1b1b1', -- status line fg
    border = '#a1b5b1',
    brown = '#504945',
    white = '#f8f8f0',
    grey = '#8F908A',
    black = '#000000',
    pink = '#f92672',
    green = '#a6e22e',
    aqua = '#66d9ef',
    yellow = '#e6db74',
    orange = '#fd971f',
    purple = '#ae81ff',
    red = '#e95678',
    diff_add = '#3d5213',
    diff_remove = '#4a0f23',
    diff_change = '#27406b',
    diff_text = '#23324d',
  }

  monokai.setup {
    palette = palette,
    italics = false,
    custom_hlgroups = {
      Comment = {
        fg = '#9ca0a4',
      },
      GitSignsAdd = {
        fg = palette.green,
        bg = palette.base2
      },
      GitSignsDelete = {
        fg = palette.pink,
        bg = palette.base2
      },
      GitSignsChange = {
        fg = palette.orange,
        bg = palette.base2
      },
    }
  }
end

function ColorMyPencils(color)
  if color == nil or color == '' then
    color = "monokai"
  end

  if color == "monokai" and monokai_available then
    setup_monokai()
  elseif color == "rose-pine" and rosepine_available then
    setup_rose_pine()
    vim.cmd.colorscheme(color)
  else
    vim.cmd.colorscheme("slate")
  end

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
