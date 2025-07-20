return {
  "echasnovski/mini.hipatterns",
  event = "VeryLazy",
  config = function()
    local ok, hipatterns = pcall(require, "mini.hipatterns")
    if not ok then
      return
    end

    local colors = {
      rosewater = "#f5e0dc",
      flamingo = "#f2cdcd",
      pink = "#f5c2e7",
      mauve = "#cba6f7",
      red = "#f38ba8",
      maroon = "#eba0ac",
      peach = "#fab387",
      yellow = "#f9e2af",
      green = "#a6e3a1",
      teal = "#94e2d5",
      sky = "#89dceb",
      sapphire = "#74c7ec",
      blue = "#89b4fa",
      lavender = "#b4befe",
      text = "#cdd6f4",
      subtext1 = "#bac2de",
      subtext0 = "#a6adc8",
      overlay0 = "#6c7086",
      overlay1 = "#7f849c",
      overlay2 = "#9399b2",
      surface0 = "#313244",
      surface1 = "#45475a",
      crust = "#11111b",
      mantle = "#181825",
      base = "#1e1e2e",
    }

    -- 1. Define all the highlight groups *once*
    for name, hex in pairs(colors) do
      local group = "Catppuccin_" .. name
      if vim.fn.hlexists(group) == 0 then
        vim.api.nvim_set_hl(0, group, { bg = hex, fg = "#1e1e2e" })
      end
    end

    -- 2. Setup mini.hipatterns
    hipatterns.setup({
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),

        catppuccin = {
          pattern = "[@$%-]+%w+",
          group = function(_, match)
            local name = match:gsub("^[@$%-]+", ""):lower()
            if colors[name] then
              return "Catppuccin_" .. name
            else
              -- Optional debug log
              -- print("No highlight group for:", match)
              return nil
            end
          end,
        },
      },
    })
  end,
}
