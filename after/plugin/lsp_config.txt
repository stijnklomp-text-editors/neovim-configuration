local cmp = require("cmp")
local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  path = "[Path]",
}

local lspkind = require("lspkind")
cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      -- vim.fn["vsnip#anonymous"](args.body)

      require("luasnip").lsp_expand(args.body)

      -- For `ultisnips` user.
      -- For `luasnip` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item({ "i", "s" }),
    ["<S-Tab>"] = cmp.mapping.select_prev_item({ "i", "s" }),        
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      if entry.source.name == "cmp_tabnine" then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          menu = entry.completion_item.data.detail .. " " .. menu
        end
        vim_item.kind = ""
      end
      vim_item.menu = menu
      return vim_item
    end,
  },

  sources = {
    -- tabnine completion? yayaya
    { name = "nvim_lsp" },
    -- For luasnip user.
    { name = "luasnip" },
    { name = "buffer" },

  },
})
--

--
local nnoremap = require("stijn.keymap").nnoremap
local inoremap = require("stijn.keymap").inoremap
-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   -- Mappings.
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   local bufopts = { noremap=true, silent=true, buffer=bufnr }
--   nnoremap('gD', vim.lsp.buf.declaration, bufopts)
--   nnoremap('gd', vim.lsp.buf.definition, bufopts)
--   nnoremap('K', vim.lsp.buf.hover, bufopts)
--   nnoremap('gi', vim.lsp.buf.implementation, bufopts)
--   nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts)
--   nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--   nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--   nnoremap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, bufopts)
--   nnoremap( '<leader>D', vim.lsp.buf.type_definition, bufopts)
--   nnoremap( '<leader>rn', vim.lsp.buf.rename, bufopts)
--   nnoremap( '<leader>ca', vim.lsp.buf.code_action, bufopts)
--   nnoremap( 'gr', vim.lsp.buf.references, bufopts)
--   nnoremap( '<leader>f', vim.lsp.buf.formatting, bufopts)
-- end

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function()
      nnoremap("gd", function() vim.lsp.buf.definition() end)
      nnoremap("K", function() vim.lsp.buf.hover() end)
      nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
      nnoremap("<leader>vp", function() vim.diagnostic.open_float() end)
      nnoremap("[d", function() vim.diagnostic.goto_next() end)
      nnoremap("]d", function() vim.diagnostic.goto_prev() end)
      nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
      nnoremap("<leader>vco", function() vim.lsp.buf.code_action({
        filter = function(code_action)
          if not code_action or not code_action.data then
            return false
          end

          local data = code_action.data.id
          return string.sub(data, #data - 1, #data) == ":0"
        end,
        apply = true
      }) end)
      nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
      nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
      inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
    end,
  }, _config or {})
end


--            }
-- This is the default in Nvim 0.7+
local lsp_flags = {
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {}
  }
}
--require("lspconfig").gopls.setup(config({
--	cmd = { "gopls", "serve" },
--	settings = {
--		gopls = {
--			analyses = {
--				unusedparams = true,
--			},
--			staticcheck = true,
--		},
--	},
--}))
