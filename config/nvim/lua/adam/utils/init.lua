local M = {}

M.cmp = require 'adam.utils.cmp'
M.lazy = require 'adam.utils.lazy'
M.lsp = require 'adam.utils.lsp'
M.format = require 'adam.utils.format'
M.mini = require 'adam.utils.mini'
M.root = require 'adam.utils.root'
M.pick = require 'adam.utils.pick'
M.config = require 'adam.utils.config'
M.ui = require 'adam.utils.ui'

local _util = require 'adam.utils._util'

M.create_undo = _util.create_undo
M.extend_or_override = _util.extend_or_override
M.get_pkg_path = _util.get_pkg_path
M.get_root_dir = _util.get_root_dir
M.get_pretty_path = _util.get_pretty_path
M.dedup = _util.dedup
M.on_very_lazy = _util.on_very_lazy
M.is_win = _util.is_win
M.is_loaded = _util.is_loaded
M.on_load = _util.on_load

return M
