---@class GremlinConfig
---@field public icon string
---@field public gremlins Gremlin[]
local C = {}

C.icon = ""

-- NOTE: Default config from vscode-gremlins
-- https://github.com/nhoizey/vscode-gremlins/blob/b46295d0c01ea102790bb9b574bddae342d1a075/package.json#L77

---@class Gremlin
---@field name string - Unicode value of the gremlin.
---@field description string - Text description of the gremlin.
---@field filetype? string|string[] - Only apply to specific filetypes.
C.gremlins = {
    {
        name = "2013",
        description = "en dash",
    },
    {
        name = "2018",
        description = "left single quotation mark",
    },
    {
        name = "2019",
        description = "right single quotation mark",
    },
    {
        name = "2029",
        description = "paragraph separator",
    },
    {
        name = "2066",
        description = "Left to right",
    },
    {
        name = "2069",
        description = "Pop directional",
    },
    {
        name = "0003",
        description = "end of text",
    },
    {
        name = "000b",
        description = "line tabulation",
    },
    {
        name = "00a0",
        description = "non breaking space",
    },
    {
        name = "00ad",
        description = "soft hyphen",
    },
    {
        name = "200b",
        description = "zero width space",
    },
    {
        name = "200c",
        description = "zero width non-joiner",
    },
    {
        name = "200e",
        description = "left-to-right mark",
    },
    {
        name = "201c",
        description = "left double quotation mark",
    },
    {
        name = "201d",
        description = "right double quotation mark",
    },
    {
        name = "202c",
        description = "pop directional formatting",
    },
    {
        name = "202d",
        description = "left-to-right override",
    },
    {
        name = "202e",
        description = "right-to-left override",
    },
    {
        name = "fffc",
        description = "object replacement character",
    },
}

return C
