call plug#begin('~/.config/nvim/autoload/plugged')
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" LSP + auto-complete
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" vim-gitgutter
Plug 'airblade/vim-gitgutter'
 
" Solarized theme
Plug 'lifepillar/vim-solarized8'
" Gruvbox theme
Plug 'morhetz/gruvbox'
call plug#end()

" Theme
" colorscheme solarized8
colorscheme gruvbox

" Telescope remaps
nnoremap <leader>ff <cmd>Telescope find_files prompt_prefix=🔍 theme=get_ivy<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers theme=get_ivy<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references theme=get_ivy<cr>
nnoremap <leader>ld <cmd>Telescope lsp_document_diagnostics theme=get_ivy<cr>
nnoremap <leader>ll <cmd>Telescope lsp_workspace_diagnostics theme=get_ivy<cr>
" nnoremap <leader>gf <cmd>Telescope git_status theme=get_dropdown<cr>
nnoremap <leader>gf <cmd>Telescope git_status<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" auto-complete
set completeopt=menuone,noinsert,noselect
"set completeopt=menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" LSP Config
" lua require'lspconfig'.rust_analyzer.setup{on_attach=require'completion'.on_attach}
" lua require'lspconfig'.rust_analyzer.setup{}
" autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

" LSP + EFM
lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	require'completion'.on_attach(client)

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<leader>lD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<leader>lg', '<cmd>lua vim.lsp.buf.references', opts)
	buf_set_keymap('n', '<leader>le', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '<leader>lp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	-- buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
	    buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
		-- vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
		-- vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
		vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
		-- vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]]
	elseif client.resolved_capabilities.document_range_formatting then
	    buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
		    hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
		    hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
		    hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
		    augroup lsp_document_highlight
		        autocmd! * <buffer>
		        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		    augroup END
		]], false)
	end
end

-- LSP
-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
-- local servers = { "pyright", "rust_analyzer", "tsserver" }
local rust_analyzer_settings = {
    ["rust-analyzer"] = {
        checkOnSave = {
            command = "clippy"
        },
    }
}
nvim_lsp.rust_analyzer.setup { on_attach = on_attach, settings = rust_analyzer_settings }
nvim_lsp.pyright.setup { on_attach = on_attach }
nvim_lsp.tsserver.setup { on_attach = on_attach }
nvim_lsp.clangd.setup { on_attach = on_attach }

-- local servers = {"rust_analyzer", "pyright"}
-- for _, lsp in ipairs(servers) do
--     -- nvim_lsp[lsp].setup { on_attach = require'completion'.on_attach }
--     nvim_lsp[lsp].setup { on_attach = on_attach }
-- end

-- EFM
nvim_lsp.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = { 'rust', 'python' },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            -- lua = {
            --     {formatCommand = "lua-format -i", formatStdin = true}
            -- }
            rust = {
                { formatCommand = "rustfmt", formatStdin = true }
            },
            python = {
                {formatCommand = "autopep8 -", formatStdin = true}
            }
        }
    },
	on_attach = on_attach
}
EOF


" vim-gitgutter
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)
nmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gd <Plug>(GitGutterPreviewHunk)
nmap <leader>gl <cmd>GitGutterQuickFix \| copen<cr>
