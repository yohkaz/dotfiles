return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "html", "rust", "python" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
