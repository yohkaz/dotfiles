-- telescope.lua

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep)
		vim.keymap.set("n", "<leader>fb", builtin.buffers)
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references)
		vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols)
		vim.keymap.set("n", "<leader>ld", function()
			builtin.diagnostics({ bufnr = 0 })
		end)
		vim.keymap.set("n", "<leader>ll", builtin.diagnostics)
		vim.keymap.set("n", "<leader>gf", builtin.git_status)

		-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		-- vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files prompt_prefix=🔍 theme=get_ivy<cr>")
		-- vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
		-- vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers theme=get_ivy<cr>")
		-- vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references theme=get_ivy<cr>")
		-- vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_document_diagnostics theme=get_ivy<cr>")
		-- vim.keymap.set("n", "<leader>ll", "<cmd>Telescope lsp_workspace_diagnostics theme=get_ivy<cr>")
		-- vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_status<cr>")
		-- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
		require("telescope").setup({
			pickers = {
				find_files = {
					theme = "ivy",
				},
				buffers = {
					theme = "ivy",
				},
				lsp_references = {
					theme = "ivy",
				},
				lsp_document_symbols = {
					theme = "ivy",
				},
				diagnostics = {
					theme = "ivy",
				},
			},
		})
	end,
}
