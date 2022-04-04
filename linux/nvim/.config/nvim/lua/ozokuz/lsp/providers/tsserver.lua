local M = {}

local orig_on_attach = nil

function M.on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  --local ts_utils = require('nvim-lsp-ts-utils')

  --ts_utils.setup {}

  --ts_utils.setup_client(client)

  orig_on_attach(client, bufnr)
end

return function(on_attach)
  orig_on_attach = on_attach
  return M
end
