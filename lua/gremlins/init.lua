local Sign = require("gremlins.sign")

local M = {}
local config = {
    icon = "",
}

M.config = config

M.setup = function(args)
    M.config = vim.tbl_deep_extend("force", M.config, args or {})
    M.signs = Sign:new("gremlins_sign", "gremlin", M.config.icon)

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "BufWinEnter", "TextChanged", "TextChangedI" }, {
        callback = function()
            M.signs:run()
        end,

        group = vim.api.nvim_create_augroup("gremlin", { clear = true }),
    })
end

return M
