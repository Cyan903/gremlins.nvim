local util = {}

---Check if current buffer is a valid file.
---@return 0|1|false
function util.is_file()
    local b = vim.fn.expand("%:p")

    return vim.bo.buftype == "" and b ~= "" and vim.fn.filereadable(b)
end

---Extract a value from a key-value table.
---@param tbl table - The table to read from.
---@param index string - The key to read from.
---@return table
function util.extract_value(tbl, index)
    local list = {}

    for i in ipairs(tbl) do
        list[#list + 1] = tbl[i][index]
    end

    return list
end

---Does table include value?
---@param tbl table - The table to read from.
---@param val string - The key to check from.
---@return boolean
function util.includes(tbl, val)
    for i in ipairs(tbl) do
        if tbl[i] == val then return true end
    end

    return false
end

return util
