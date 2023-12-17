return require('packer').startup(function(use)

-- Packer can manage itself
use 'wbthomason/packer.nvim'

-- Color scheme
use 'Mofiqul/vscode.nvim'

-- Intellisense, LSP, CMP
use ( "onsails/lspkind.nvim" )
use ( "williamboman/mason.nvim" )
use ( "williamboman/mason-lspconfig.nvim" )
use ( "neovim/nvim-lspconfig" )

-- Linters
use({
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
})

-- Other --
use ( "nvim-lua/plenary.nvim" )
use ( "L3MON4D3/LuaSnip" )
use ( "hrsh7th/cmp-nvim-lsp" )
use ( "saadparwaiz1/cmp_luasnip" )
use ( "hrsh7th/cmp-buffer" )
use ( "hrsh7th/cmp-path" )
use ( "nvim-treesitter/nvim-treesitter" )
use ( "hrsh7th/nvim-cmp" )
use ( "MunifTanjim/eslint.nvim" )
--use ( "MunifTanjim/prettier.nvim" )
--use ( "fsouza/prettierd" )

use {
	"nvim-telescope/telescope.nvim", branch = "0.1.x",
	requires = { {"nvim-lua/plenary.nvim"} }
}
end)
