cache = true

std = luajit
codes = true

self = false

-- Glorious list of warnings: https://luacheck.readthedocs.io/en/stable/warnings.html
ignore = { "212", "122" }

-- Global objects defined by the C code
read_globals = { "vim" }
