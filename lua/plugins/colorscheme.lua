-- 1. THE RECOVERY FUNCTION (Define this at the top)
local function fix_my_colors()
  vim.opt.termguicolors = false

  local function set_hl(group, fg, bg)
    vim.api.nvim_set_hl(0, group, { ctermfg = fg, ctermbg = bg or "none", force = true })
  end

  -- NUKE ALL BACKGROUNDS
  local transparent_groups = {
    "Normal",
    "NormalNC",
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "SignColumn",
    "StatusLine",
    "StatusLineNC",
    "LineNr",
    "CursorLineNr",
    "WinSeparator",
    "VertSplit",
    "EndOfBuffer",
  }
  for _, g in ipairs(transparent_groups) do
    set_hl(g, nil, "none")
  end

  -- FIX UNREADABLE DARK BLUE TEXT
  set_hl("@variable.member", 7) -- email: -> White
  set_hl("@property", 7) -- property names -> White
  set_hl("@variable.builtin", 9) -- console/window -> Bright Red
  set_hl("@constant.builtin", 9) -- true/false -> Bright Red
  set_hl("@punctuation.bracket", 9)
  set_hl("@punctuation.delimiter", 9)

  -- CORE SYNTAX (3024 Night Palette)
  set_hl("Keyword", 5) -- Pink
  set_hl("Function", 4) -- Blue
  set_hl("String", 2) -- Green
  set_hl("Identifier", 1) -- Red
  set_hl("Comment", 8) -- Grey
  set_hl("Operator", 6) -- Cyan
end

-- 2. CREATE THE WATCHDOG (Outside the return block)
-- This fixes the "init" error and keeps the background transparent
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "VimEnter", "ColorScheme" }, {
  callback = function()
    fix_my_colors()
    if vim.bo.filetype == "NvimTree" then
      -- This is the specific "Blue Background" killer for NvimTree
      vim.wo.winhighlight = "Normal:NvimTreeNormal,NormalNC:NvimTreeNormalNC"
    end
  end,
})

-- 3. THE ACTUAL PLUGIN LIST
return {
  {
    "tinted-theming/tinted-vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme base16-default-dark")
      vim.g.tinted_background_transparent = 1
      -- fix_my_colors()
    end,
  },

  -- Re-enable NvimTree's internal features without the blue
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      opts.renderer = opts.renderer or {}
      opts.renderer.highlight_git = true
      opts.renderer.icons.show.git = true
      vim.g.nvim_tree_window_highlights = 0
    end,
  },
}
