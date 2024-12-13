local util = require("gremlins.util")

local SIGN_GROUP = "gremlins_sign"
local SIGN_NAME = "gremlin"

local Sign = {}

Sign.__index = Sign

function Sign:new(icon, signs)
    self.index = self

    local sign = setmetatable({
        icon = icon,
        signs = signs,
        list = {},
    }, self)

    vim.fn.sign_define(SIGN_NAME, { text = sign.icon })

    return sign
end

function Sign:_check(line)
    for _, c in ipairs(self.signs) do
        local name = c
        local description = "Unknown"

        if type(name) == "table" then
            name = c.name
            description = c.description
        end

        if vim.regex("\\%u" .. name):match_str(line) then return true, name, description end
    end

    return false
end

function Sign:_empty()
    if #self.list == 0 then vim.print("[gremlins.nvim] No gremlins in file!") end

    return #self.list == 0
end

function Sign:run()
    if not util.is_file() then return end

    vim.fn.sign_unplace(SIGN_GROUP)
    self.list = {}

    for i = 1, vim.fn.line("$") do
        local line = vim.fn.getline(i)
        local check, name, description = self:_check(line)

        if check then
            vim.fn.sign_place(0, SIGN_GROUP, SIGN_NAME, "%", { lnum = i })
            self.list[#self.list + 1] = {
                name = i .. " - " .. description .. " (" .. name .. ")",
                index = i,
            }
        end
    end
end

function Sign:open()
    local list = util.extract_value(self.list, "name")

    if self:_empty() then return end

    vim.ui.select(list, { prompt = "Select Gremlin" }, function(gremlin_name)
        if not gremlin_name then return end

        for _, n in ipairs(self.list) do
            if n.name == gremlin_name then
                vim.api.nvim_win_set_cursor(0, { n.index, 0 })
                break
            end
        end
    end)
end

function Sign:next()
    local row = unpack(vim.api.nvim_win_get_cursor(0))
    local indexes = util.extract_value(self.list, "index")
    local next = -1

    if self:_empty() then return end

    for _, v in ipairs(indexes) do
        if v > row then
            next = v
            break
        end
    end

    if row >= indexes[#indexes] then
        vim.api.nvim_win_set_cursor(0, { indexes[1], 0 })
        return
    end

    vim.api.nvim_win_set_cursor(0, { next, 0 })
end

function Sign:prev()
    local row = unpack(vim.api.nvim_win_get_cursor(0))
    local indexes = util.extract_value(self.list, "index")
    local next = -1

    if self:_empty() then return end

    for i = #indexes, 1, -1 do
        if indexes[i] < row then
            next = indexes[i]
            break
        end
    end

    if row <= indexes[1] then
        vim.api.nvim_win_set_cursor(0, { indexes[#indexes], 0 })
        return
    end

    vim.api.nvim_win_set_cursor(0, { next, 0 })
end

return Sign
