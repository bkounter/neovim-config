return {
  {
    -- Path to your local development folder
    dir = "~/Dev/nvim-plugins/terminal-colors.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- This calls the setup function in your new plugin's init.lua
      require("terminal-colors").setup()

      -- This activates the theme
      vim.cmd("colorscheme terminal-colors")
    end,
  },
}
