local util = require("gremlins.util")

local SIGN_GROUP = "gremlins_sign"
local SIGN_NAME = "gremlin"

---@class Sign
---@field public icon string - The icon used in the sign column.
---@field public signs table - The table of signs.
local Sign = {}

Sign.__index = Sign

---Sign Constructor
---@param icon string - The icon to use.
---@param signs table - The table to use
---@return Sign
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

---Check for gremlins in a line.
---@private
---@param line string - The line to check.
---@return boolean, string, string - Gremlin status, name, description.
function Sign:_check(line)
    for _, c in ipairs(self.signs) do
        local name = c
        local description = "Unknown"
        local ft = true

        if type(name) == "table" then
            name = c.name
            description = c.description

            if type(c.filetype) == "string" then
                ft = vim.bo.filetype == c.filetype
            elseif type(c.filetype) == "table" then
                ft = util.includes(c.filetype, vim.bo.filetype)
            end
        end

        -- stylua: ignore
        if vim.regex("\\%u" .. name):match_str(line) and ft then
            return true, name, description
        end
    end

    return false, "", ""
end

---Check if the current file contains a gremlin.
---@private
---@return boolean empty - Is the file free of gremlins?
function Sign:_empty()
    if #self.list == 0 then vim.print("[gremlins.nvim] No gremlins in file!") end

    return #self.list == 0
end

---Run a gremlin check on the current buffer/file.
---@return nil
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

---Open `vim.ui.select` with a list of gremlins in the current file.
---@return nil
function Sign:select()
    if self:_empty() then return end

    vim.ui.select(util.extract_value(self.list, "name"), { prompt = "Select Gremlin" }, function(gremlin_name)
        if not gremlin_name then return end

        for _, n in ipairs(self.list) do
            if n.name == gremlin_name then
                vim.api.nvim_win_set_cursor(0, { n.index, 0 })
                break
            end
        end
    end)
end

---Create a quickfix list of gremlins.
---@return nil
function Sign:qflist()
    if self:_empty() then
        vim.fn.setqflist({}, "r")
        return
    end

    local filename = vim.fn.expand("%:p")
    local list = {}

    for _, n in ipairs(self.list) do
        list[#list + 1] = { filename = filename, lnum = n.index, text = n.name }
    end

    vim.fn.setqflist(list, "r")
    if #vim.fn.getqflist() > 0 then vim.cmd("copen") end
end

---Jump to next gremlin (if it exists).
---@return nil
function Sign:next()
    if self:_empty() then return end

    local row = unpack(vim.api.nvim_win_get_cursor(0))
    local indexes = util.extract_value(self.list, "index")
    local next = -1

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

---Jump to previous gremlin (if it exists).
---@return nil
function Sign:prev()
    if self:_empty() then return end

    local row = unpack(vim.api.nvim_win_get_cursor(0))
    local indexes = util.extract_value(self.list, "index")
    local next = -1

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
