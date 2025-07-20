return {
  {
    "elkowar/yuck.vim",
    ft = "yuck",
    config = function()
      -- Optional: Set any yuck-specific settings here
      vim.g.yuck_format_on_save = false
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Add filetype detection
      vim.filetype.add({
        extension = { yuck = "yuck" },
        filename = { ["eww.yuck"] = "yuck" },
        pattern = { [".*/eww/.*%.yuck"] = "yuck" },
      })

      -- Only add yuck to ensure_installed if you have the parser available
      -- Comment this out if you don't have a custom tree-sitter-yuck parser
      -- vim.list_extend(opts.ensure_installed, { "yuck" })
    end,
  },
}
