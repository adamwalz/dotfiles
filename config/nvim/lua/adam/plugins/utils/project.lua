local utils = require 'adam.utils'
local project_picker = require 'adam.plugins.project_picker'

return {
  {
    "ahmedkhalf/project.nvim",
    commit = '8c6bad7',
    opts = {
      manual_mode = true,
    },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("project_nvim.project").init()
      local history = require("project_nvim.utils.history")
      history.delete_project = function(project)
        for k, v in pairs(history.recent_projects) do
          if v == project.value then
            history.recent_projects[k] = nil
            return
          end
        end
      end
      utils.on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fp", project_picker.pick, desc = "Projects" },
    },
  },
}
