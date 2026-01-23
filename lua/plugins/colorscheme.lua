return {
  {
    "tinted-theming/tinted-vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = false -- Use terminal ANSI colors
      vim.g.tinted_background_transparent = 1
      vim.cmd("colorscheme base16-default-dark")

      local function apply_manual_map()
        -- PALETTE DEFINITIONS (Standard ANSI 16)
        local red = 1
        local green = 2
        local yellow = 3
        local blue = 4
        local magenta = 5
        local cyan = 6
        local white = 7
        local grey = 8

        local function set(group, fg, bg)
          vim.api.nvim_set_hl(0, group, { ctermfg = fg, ctermbg = bg or "none", force = true })
        end

        -- 1. CORE SYNTAX (Broken out by color)
        set("Normal", white, "none")
        set("Keyword", magenta)
        set("Statement", red)
        set("Identifier", red)
        set("Function", blue)
        set("String", green)
        set("Number", yellow)
        set("Boolean", yellow)
        set("Type", yellow)
        set("Operator", cyan)
        set("Special", cyan)
        set("Comment", grey)

        -- 2. TREESITTER (The Blue & White killers)
        set("@variable", white)
        set("@variable.member", white)
        set("@variable.builtin", red)
        set("@property", cyan)
        set("@field", cyan)
        set("@parameter", white)
        set("@function", blue)
        set("@function.call", blue)
        set("@method", blue)
        set("@keyword", magenta)
        set("@string", green)
        set("@constant", yellow)
        set("@constant.builtin", yellow)
        set("@punctuation.bracket", white)
        set("@punctuation.delimiter", white)
        set("@tag", red)
        set("@tag.attribute", yellow)

        -- 3. UI & HIGHLIGHTS
        set("LineNr", grey, "none")
        set("CursorLineNr", yellow, "none")
        set("Visual", 0, yellow) -- Selection: Black text (0) on Yellow (3)
        set("Search", 0, yellow)
        set("WinSeparator", grey, "none")
        set("CursorLine", nil, 0) -- Dark background for current line

        -- 4. EXPLORER (Snacks/NeoTree)
        set("SnacksNormal", white, "none")
        set("SnacksPicker", white, "none")
        set("NeoTreeNormal", white, "none")
        set("NeoTreeDirectoryName", blue)
        set("NeoTreeFileName", white)
        set("NeoTreeSymbolicLinkTarget", cyan)
      end

      -- DISABLE SEMANTIC TOKENS (Prevents LSP from overriding our colors)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })

      apply_manual_map()

      -- Watchdog to maintain the theme during buffer switches
      vim.api.nvim_create_autocmd({ "BufEnter", "ColorScheme", "FileType" }, {
        callback = apply_manual_map,
      })
    end,
  },
}
