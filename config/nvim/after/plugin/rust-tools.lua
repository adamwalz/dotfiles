local rusttools_available, rusttools = pcall(require, "rust-tools")

if rusttools_available then
  rusttools.setup({
    server = {
      on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "<Leader>ra", rusttools.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<Leader>rc", rusttools.code_action_group.code_action_group, { buffer = bufnr })
      end,
    },
  })
end
