return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    local eslint = lint.linters.eslint_d

    -- if Eslint error configuration not found : change MasonInstall eslint@version or npm i -g eslint at a specific version
    lint.linters_by_ft = {
      javascript = { "biomejs" },
      typescript = { "biomejs" },
      javascriptreact = { "biomejs" },
      typescriptreact = { "biomejs" },
      svelte = { "biomejs" },
      python = { "pylint" },
    }

    eslint.args = {
      "--no-warn-ignored",
      "--format",
      "json",
      "--stdin",
      "--stdin-filename",
      function()
        return vim.fn.expand("%:p")
      end,
    }

    -- Set pylint to work in virtualenv
    require("lint").linters.pylint.cmd = "python"
    require("lint").linters.pylint.args = { "-m", "pylint", "-f", "json" }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
