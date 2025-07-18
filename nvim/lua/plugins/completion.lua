return {
    'saghen/blink.cmp',
    -- use a release tag to download pre-built binaries
    version = '1.*',

    opts = {
        keymap = { preset = 'default' },

        appearance = {
            nerd_font_variant = 'mono'
        },

        signature = { enabled = true }

        -- (Default) Only show the documentation popup when manually triggered
        -- completion = { documentation = { auto_show = false } },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        -- sources = {
        --     default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        -- fuzzy = { implementation = "prefer_rust_with_warning" }
    },
}
