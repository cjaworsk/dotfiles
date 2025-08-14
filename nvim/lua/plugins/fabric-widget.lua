return {
  {
    "akinsho/toggleterm.nvim",
    optional = true, -- already included in LazyVim
    keys = {
      {
        "<leader>fw",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local fabric_widget = Terminal:new({
            cmd = "~/.venvs/fabric-gtk/bin/python ~/projects/fabric-bar/app.py",
            hidden = true,
            direction = "float",
            close_on_exit = false,
          })
          fabric_widget:toggle()
        end,
        desc = "Run Fabric Widget",
      },
    },
  },
}
