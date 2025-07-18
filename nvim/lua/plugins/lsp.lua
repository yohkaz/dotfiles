local on_attach = function(client, bufnr)
    -- Disable highlighting from LSP as TreeSitter takes care of it
    -- client.server_capabilities.semanticTokensProvider = nil

    -- Mappings
    local nmap = function(keys, func)
        vim.keymap.set("n", keys, func, { buffer = bufnr })
    end
    nmap("gD", vim.lsp.buf.declaration)
    nmap("gd", vim.lsp.buf.definition)
    nmap("K", vim.lsp.buf.hover)
    nmap("gi", vim.lsp.buf.implementation)
    nmap("<C-k>", vim.lsp.buf.signature_help)
    nmap("<leader>lwa", vim.lsp.buf.add_workspace_folder)
    nmap("<leader>lwr", vim.lsp.buf.remove_workspace_folder)
    --nmap("<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
    nmap("<leader>lD", vim.lsp.buf.type_definition)
    nmap("<leader>lr", vim.lsp.buf.rename)
    nmap("<leader>la", vim.lsp.buf.code_action)
    nmap("<leader>lg", vim.lsp.buf.references)
    --nmap("<leader>le", "<cmd>lua vim.diagnostic.open_float({scope="line"})<CR>")
    nmap("<leader>le", vim.diagnostic.open_float)
    nmap("<leader>lp", vim.diagnostic.goto_prev)
    nmap("<leader>ln", vim.diagnostic.goto_next)

    -- attach autoformat
    require("plugins.autoformat").on_attach(client, bufnr)
end

local servers = {
    clangd = {},
    pyright = {},
    rust_analyzer = {
        rust_analyzer = {
            checkOnSave = {
                command = "clippy"
            },
        }
    },
    ts_ls = {},

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp"
    },
    config = function(_, _)
        -- Completion capabilities
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        local mason_lspconfig = require("mason-lspconfig")
        -- Ensure the servers above are installed
        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }
        -- Attach keymaps + completion to each server
        mason_lspconfig.setup_handlers {
            function(server_name)
                require("lspconfig")[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                }
            end,
        }
    end,
    opts = {
        autoformat = true,
    },
}
