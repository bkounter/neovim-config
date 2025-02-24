return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Ensures it loads first
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- Use terminal's colors
        transparent_mode = true, -- Keep transparency
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
