return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs, buffers",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  -- statusline
  { "nvim-lualine/lualine.nvim", event = "VeryLazy", opts = { options = { theme = "tokyonight" } } },
}
