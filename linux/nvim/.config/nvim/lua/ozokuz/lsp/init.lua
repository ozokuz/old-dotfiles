local M = {}

function M.setup()
  local nvim_lsp = require('lspconfig')

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- setup lsp_signature
    require('lsp_signature').on_attach()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    if client.name == 'tsserver' then
      client.resolved_capabilities.document_formatting = false
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'angularls', 'bashls', 'cssls', 'dockerls', 'eslint', 'graphql', 'html', 'jsonls', 'pyright', 'sumneko_lua', 'tailwindcss', 'tsserver', 'volar', 'yamlls' }
  for _, lsp in ipairs(servers) do
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }

    if lsp == 'sumneko_lua' then
      opts = vim.tbl_deep_extend('force', opts, require('ozokuz.lsp.providers.sumneko_lua'))
    elseif lsp == 'tsserver' then
      opts = vim.tbl_deep_extend('force', opts, require('ozokuz.lsp.providers.tsserver')(on_attach))
    end

    nvim_lsp[lsp].setup(opts)
  end

  nvim_lsp.diagnosticls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'markdown', 'css', 'less', 'scss', 'lua' },
    init_options = {
      formatFiletypes = {
        javascript = 'prettier',
        javascriptreact = 'prettier',
        typescript = 'prettier',
        typescriptreact = 'prettier',
        json = 'prettier',
        markdown = 'prettier',
        css = 'prettier',
        less = 'prettier',
        scss = 'prettier',
        lua = 'stylua'
      },
      formatters = {
        prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}},
        stylua = {command = "stylua", args = {"--stdin-filepath", "%filepath"}}
      }
    }
  }
end

return M
