local copilot_available, copilot = pcall(require, "copilot")
local copilot_cmp_available, copilot_cmp = pcall(require, "copilot_cmp")

if copilot_available then
  copilot.setup({
    filetypes = {
      javascript = true,
      typescript = true,
      python = true,
      rust = true,
      ["*"] = false, -- disallow all other filetypes
    },
    server_opts_overrides = {
      trace = "verbose",
      settings = {
        advanced = {
          DebugEnableGitHubTelemetry = false,
        }
      },
    },
    -- It is recommended to disable suggestion and panel modules, as they can
    -- interfere with completions properly appearing in copilot-cmp
    suggestion = { enabled = false },
    panel = { enabled = false },
  })

  if copilot_cmp_available then
    copilot_cmp.setup({
      -- getPanelCompletions previously worked just as quickly, and did not limit
      -- completions in the cmp menu to 3 recommendations, but has become so
      -- slow completions do not seem to appear due to recent changes from Microsoft
      method = "getCompletionsCycling",
      formatters = {
        label = require("copilot_cmp.format").format_label_text,
        insert_text = require("copilot_cmp.format").format_insert_text,
        preview = require("copilot_cmp.format").deindent,
      },
    })
  end
end

