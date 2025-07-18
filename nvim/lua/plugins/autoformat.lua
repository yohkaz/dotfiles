local lsp_formatting = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    local null_ls = package.loaded["null-ls"] and require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING")
        or {}
    local filter_func = function(client)
        if #null_ls > 0 then
            return client.name == "null-ls"
        end
        return true
    end
    vim.lsp.buf.format({
        filter = filter_func,
        bufnr = bufnr,
    })
end

-- set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
                --vim.lsp.buf.format({
                --    bufnr = bufnr,
                --})
            end,
        })
    end
end

return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        require("mason-null-ls").setup({
            ensure_installed = { "ruff" },
            automatic_installation = false,
            handlers = {},
        })
        require("null-ls").setup({
            sources = {
                -- Anything not supported by mason.
            },
            on_attach = on_attach,
        })
    end,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end,
}
