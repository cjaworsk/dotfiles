return {
  "norcalli/nvim-colorizer.lua",
  event = "BufReadPre",
  config = function()
    require("colorizer").setup({
      "*", -- Apply to all filetypes
    }, {
      names = false, -- Disable named colors like "red"
      RGB = true, -- Enable #RGB
      RRGGBB = true, -- Enable #RRGGBB
      RRGGBBAA = true, -- Enable #RRGGBBAA
      rgb_fn = true, -- Enable rgb(...) and rgba(...)
      hsl_fn = true, -- Enable hsl(...) and hsla(...)
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, etc.
      css_fn = true,
    })
  end,
}
