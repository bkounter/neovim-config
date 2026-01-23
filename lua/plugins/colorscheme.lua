return {
  {
    "sainnhe/everforest",
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard" -- Options: 'soft', 'medium', 'hard'
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_transparent_background = 1 -- Enable transparency
      vim.g.everforest_better_performance = 1
      vim.g.everforest_termcolors = "256" -- Use terminal colors
      vim.cmd("colorscheme everforest")
    end,
  },
}
