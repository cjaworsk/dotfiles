return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      float_opts = {
        border = "curved",
      },
    })
  end,
  keys = {
    {
      "<leader>tf",
      "<cmd>ToggleTerm direction=float<cr>",
      desc = "Toggle Floating Terminal",
    },
    {
      "<leader>th",
      "<cmd>ToggleTerm direction=horizontal<cr>",
      desc = "Toggle Horizontal Terminal",
    },
    {
      "<leader>tv",
      "<cmd>ToggleTerm direction=vertical<cr>",
      desc = "Toggle Vertical Terminal",
    },
  },
}
