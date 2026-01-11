return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"kazhala/close-buffers.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>bd",
				function()
					require("close-buffers").delete({ type = "this" })
				end,
				desc = "Close current buffer",
			},
			{
				"<leader>bo",
				function()
					require("close-buffers").delete({ type = "other" })
				end,
				desc = "Close other buffers",
			},
		},
		opts = {
			preserve_window_layout = { "this", "nameless" }, -- ウィンドウの分割状態を維持する設定
			next_buffer_cmd = function(windows)
				require("bufferline").cycle(1) -- bufferlineなどを使っている場合の連携
			end,
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
}
