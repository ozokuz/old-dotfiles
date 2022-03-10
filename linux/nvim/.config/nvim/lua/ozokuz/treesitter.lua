local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "cmake",
      "comment",
      "cpp",
      "css",
      "dart",
      "dockerfile",
      "go",
      "gomod",
      "graphql",
      "html",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "kotlin",
      "lua",
      "php",
      "python",
      "regex",
      "rst",
      "ruby",
      "rust",
      "scss",
      "svelte",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vue",
      "yaml"
    },
    highlight = {
      enable = true
    },
    rainbow = {
      enable = true,
      extended_mode = true
    }
  }
end

return M
