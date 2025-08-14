return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "biome-check" },
      typescript = { "biome-check" },
      javascriptreact = { "biome-check" },
      typescriptreact = { "biome-check" },
      css = { "biome-check" },
      html = { "biome-check" },
      svelte = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      graphql = { "prettier" },
      liquid = { "prettier" },
      lua = { "stylua" },
      python = { "black" },
      markdown = { "prettier", "markdown-toc" },
      -- ["markdown.mdx"] = { "prettier", "markdownlint", "markdown-toc" },
    },
  },
}
