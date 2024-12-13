local Sign = require("gremlins.sign")

---@class GremlinModule
---@field public config GremlinConfig
local M = { config = require("gremlins.config") }

--- Gremlins Setup
---@param args GremlinConfig
M.setup = function(args)
    -- TODO: Test if extending config.gremlins works
    M.config = vim.tbl_deep_extend("force", M.config, args or {})
    M.signs = Sign:new(M.config.icon, M.config.gremlins)

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "BufWinEnter", "TextChanged", "TextChangedI" }, {
        callback = function() M.signs:run() end,
        group = vim.api.nvim_create_augroup("gremlin", { clear = true }),
    })
end

--- Open Popup
M.open = function() M.signs:open() end

--- Jump to next gremlin.
M.next = function() M.signs:next() end

-- Jump to previous gremlin.
M.prev = function() M.signs:prev() end

return M
