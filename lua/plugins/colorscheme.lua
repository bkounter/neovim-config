return {
  {
    "tinted-theming/tinted-vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.tinted_background_transparent = 1
      vim.cmd.colorscheme("base16-ayu-dark")
    end,
  },
}
