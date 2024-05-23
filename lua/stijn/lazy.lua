local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
	-- Color scheme
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme vscode]])
        end,
    },
	-- Intellisense, LSP, CMP
	"onsails/lspkind.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	-- Linters
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local eslint = require("eslint")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettierd.with({
						filetypes = { 
							"css", "json", "jsonc","javascript", "typescript",
							"javascript.glimmer", "typescript.glimmer",
							"handlebars"
						}
					}),
					null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.completion.luasnip,
					on_attach = on_attach
				}
			})

			eslint.setup({
				bin = 'eslint', -- or `eslint_d`
				code_actions = {
					enable = true,
					apply_on_save = {
						enable = true,
						types = { "directive", "problem", "suggestion", "layout" },
					},
					disable_rule_comment = {
						enable = true,
						location = "separate_line", -- or `same_line`
					},
				},
				diagnostics = {
					enable = true,
					run_on = "type", -- or `save`
				},
				--fix on save
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
		end,
		requires = { "nvim-lua/plenary.nvim" },
	},
	-- Other --
	"nvim-lua/plenary.nvim",
	"L3MON4D3/LuaSnip",
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"nvim-treesitter/nvim-treesitter",
	"hrsh7th/nvim-cmp",
	"MunifTanjim/eslint.nvim",
	"MunifTanjim/prettier.nvim",
	"fsouza/prettierd"
	--{
	--	"nvim-telescope/telescope.nvim",
	--	branch = "0.1.x",
	--	requires = { {"nvim-lua/plenary.nvim"} }
	--}
}, {})
