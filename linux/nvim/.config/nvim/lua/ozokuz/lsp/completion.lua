local M = {}

function M.setup()
  local cmp = require('cmp')

  vim.o.completeopt = "menu,menuone,noselect"

  cmp.setup {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'emoji' },
      { name = 'calc' },
      { name = 'luasnip' },
      { name = 'cmp_git' }
    },
    formatting = {
      format = require('lspkind').cmp_format()
    }
  }

  cmp.setup.cmdline(':', {
    sources = {
      { name = 'cmdline' }
    }
  })

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'nvim_lsp_document_symbol' },
      { name = 'buffer' }
    }
  })

  require('cmp_git').setup {}
end

return M
