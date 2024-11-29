local function is_file()
    local b = vim.fn.expand("%:p")
    return vim.bo.buftype == "" and b ~= "" and vim.fn.filereadable(b)
end

local function check(line)
    -- From vscode-gremlins
    -- TODO: Improve this
    local regex = vim.regex(
        [[2013+|2018+|2019+|2029+|2066+|2069+|0003+|000b+|00a0+|00ad+|200b+|200c+|200e+|201c+|201d+|202c+|202d+|202e+|fffc+]]
    )

    local ms, _ = regex:match_str(line)

    return ms
end

local Sign = {}

Sign.__index = Sign

function Sign:new(group, name, text)
    self.index = self

    local sign = setmetatable({
        group = group,
        name = name,
        text = text,
    }, self)

    vim.fn.sign_define(sign.name, { text = sign.text })

    return sign
end

function Sign:run()
    if not is_file() then
        return
    end

    vim.fn.sign_unplace(self.group)

    for i = 1, vim.fn.line("$") do
        local line = vim.fn.getline(i)

        if check(line) then
            vim.fn.sign_place(0, self.group, self.name, "%", { lnum = i })
        end
    end
end

return Sign
