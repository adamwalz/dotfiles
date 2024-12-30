local project_picker = require 'adam.plugins.project_picker'

return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    table.insert(opts.dashboard.preset.keys, 3, {
      action = project_picker.pick,
      desc = "Projects",
      icon = " ",
      key = "p",
    })
  end,
}
