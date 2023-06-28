return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add          = { text = "+" },
            change       = { text = "~" },
            delete       = { text = "_" },
            topdelete    = { text = "‾" },
            changedelete = { text = "~" },
            untracked    = { text = "┆" },
        },
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")
            vim.keymap.set("n", "<leader>gp", gitsigns.prev_hunk, { buffer = bufnr })
            vim.keymap.set("n", "<leader>gn", gitsigns.next_hunk, { buffer = bufnr })
            vim.keymap.set("n", "<leader>gd", gitsigns.preview_hunk, { buffer = bufnr })
            vim.keymap.set("n", "<leader>gb", function() gitsigns.blame_line { full = true } end, { buffer = bufnr })
        end,
    },
}
