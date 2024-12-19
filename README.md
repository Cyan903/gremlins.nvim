# gremlins.nvim

![code-size](https://img.shields.io/github/languages/code-size/cyan903/gremlins.nvim) ![last-commit](https://img.shields.io/github/last-commit/cyan903/gremlins.nvim) ![license](https://img.shields.io/github/license/cyan903/gremlins.nvim)

A Neovim rewrite of the [vscode-gremlins](https://marketplace.visualstudio.com/items?itemName=nhoizey.gremlins) extension, designed to reveal unwanted or invisible characters in your code. 

## Quickstart with lazy.nvim

```lua
return {
    "Cyan903/gremlins.nvim",

    opts = {},

    config = function(_, opts)
        local gremlins = require("gremlins")

        -- Open popup.
        vim.keymap.set("n", "<leader>gs", gremlins.select, { desc = "Gremlins select." })

        -- Create quickfix list.
        vim.keymap.set("n", "<leader>gc", gremlins.qflist, { desc = "Gremlins quickfix." })

        -- Jump to next gremlin.
        vim.keymap.set("n", "<leader>gj", gremlins.next, { desc = "Gremlins next." })

        -- Jump to previous gremlin.
        vim.keymap.set("n", "<leader>gk", gremlins.prev, { desc = "Gremlins previous." })

        gremlins.setup(opts)
    end,
}
```

## Configuration

The default configuration is recommended, but custom parameters can be provided through the setup function. Gremlins with a custom file type will only appear in the specified file type. You can view the default config in [config.lua](lua/gremlins/config.lua).

```lua
require("gremlins").setup {
    icon = "😈",
    gremlins = {
        -- NOTE: Gremlins can simply be strings.
        "2013",

        -- NOTE: Or be more descriptive with a specified filetype.
        {
            name = "2013",
            description = "en dash",
            filetype = "markdown",
        },

        -- NOTE: Multiple filetypes are supported.
        {
            name = "2013",
            description = "en dash",
            filetype = { "markdown", "go" },
        },
    }
}
```

## API

`.setup()` must be called before the API can be used.

```lua
-- Open `vim.ui.select` with a list of gremlins in the current file.
require("gremlins").select()

-- Create and open a quickfix list of gremlins in the current file.
require("gremlins").qflist()

-- Jump to previous gremlin in file.
require("gremlins").next()

-- Jump to previous gremlin in file.
require("gremlins").prev()
```

## License

[MIT](LICENSE)

