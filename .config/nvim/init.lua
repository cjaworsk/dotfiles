-- bootstrap lazy.nvim, LazyVim and your plugins

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.transparent")

require("catppuccin").setup({
  flavour = "mocha", -- or latte, frappe, macchiato
  integrations = {
    -- nvimtree = true,
    --  enable specific integrations e.g.
    --  `nvim-tree = true`
  },
})

-- in your LSP config for tsserver
require("lspconfig").tsserver.setup({
  root_dir = require("lspconfig.util").root_pattern("tsconfig.json"),
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.yuck",
  callback = function()
    vim.bo.filetype = "yuck"
  end,
})

-- Load the colorscheme
--vim.cmd.colorscheme("catppuccin-mocha") -- Or your chosen flavour
