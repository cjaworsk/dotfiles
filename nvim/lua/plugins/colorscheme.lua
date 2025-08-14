return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true, -- 👈 this is what you want
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true, -- 👈 enable transparency
    },
    require("catppuccin").load(),
  },

  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,

    config = function()
      require("nordic").setup({
        transparent_bg = true,
      })
    end,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    config = function()
      -- Optional Nord options
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = true
      vim.g.nord_italic = true
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
    end,
  },
}
