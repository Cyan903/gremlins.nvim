return {
    is_file = function()
        local b = vim.fn.expand("%:p")

        return vim.bo.buftype == "" and b ~= "" and vim.fn.filereadable(b)
    end,

    extract_value = function(tbl, index)
        local list = {}

        for i in ipairs(tbl) do
            list[#list + 1] = tbl[i][index]
        end

        return list
    end,
}
