local snippy_available, snippy = pcall(require, "snippy")

if snippy_available then
  snippy.setup({
    mappings = {
      is = {
        ['<Tab>'] = 'expand_or_advance',
        ['<S-Tab>'] = 'previous',
      },
      nx = {
        ['<leader>x'] = 'cut_text',
      },
    },
  })
end
