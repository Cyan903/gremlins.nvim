local module = require(... .. ".module")

---@class Gremlins
local M = {}

---@class Config
---@field opt nil
local config = { opt = nil }

---@type Config
M.config = config

---@param args Config?
M.setup = function(args)
    M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

return M
