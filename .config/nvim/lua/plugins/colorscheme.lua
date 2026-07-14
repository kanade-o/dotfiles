return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        style = "moon",
        on_highlights = function(hl, colors)
          hl.Comment = {
            fg = "#b8bccb",
            italic = true,
          }
          hl.CursorLine = {
            bg = colors.none,
          }
          hl.CursorLineHr = {
            bg = colors.cyan,
            bold = true,
          }
        end,
      }
    end,
  },
}
