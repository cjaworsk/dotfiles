-- bootstrap lazy.nvim, LazyVim and your plugins
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

-- Load the colorscheme
vim.cmd.colorscheme("catppuccin-mocha") -- Or your chosen flavour
