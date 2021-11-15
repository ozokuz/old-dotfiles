local M = {}

function M.setup()
  require('telescope').load_extension('media_files')
  require('telescope').load_extension('gh')
  require('telescope').setup {
    extensions = {
      filetypes = {"png", "jpg", "jpeg", "webp", "gif"}
    }
  }
end

return M
