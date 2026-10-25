return {
	-- Configuration for Comment.nvim
	{
		"numToStr/Comment.nvim",
		opts = {}, -- Configuration options for Comment.nvim
	},

	-- Configuration for todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		event = "VimEnter", -- Load the plugin when VimEnter event is fired
		dependencies = { "nvim-lua/plenary.nvim" }, -- Dependencies that need to be loaded first
		opts = {
			signs = false, -- Configuration options for todo-comments.nvim
		},
	},
}
