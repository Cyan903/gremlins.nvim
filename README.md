# gremlins.nvim

A Neovim rewrite of the [vscode-gremlins](https://marketplace.visualstudio.com/items?itemName=nhoizey.gremlins) extension, designed to reveal unwanted or invisible characters in your code. 


## Lazy Quickstart

```lua
return {
    "Cyan903/gremlins.nvim",

    opts = {},
    config = function(_, opts)
        local gremlins = require("gremlins")

        ---Open popup.
        vim.keymap.set("n", "<leader>gs", gremlins.select, { desc = "Gremlins select." })

        ---Create quickfix list.
        vim.keymap.set("n", "<leader>gc", gremlins.qflist, { desc = "Gremlins quickfix." })

        ---Jump to next gremlin.
        vim.keymap.set("n", "<leader>gj", gremlins.next, { desc = "Gremlins next." })

        ---Jump to previous gremlin.
        vim.keymap.set("n", "<leader>gk", gremlins.prev, { desc = "Gremlins previous." })

        gremlins.setup(opts)
    end,
}
```

## License

[MIT](LICENSE)

