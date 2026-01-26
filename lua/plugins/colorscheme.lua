return {
  {
    "chriskempson/base16-vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = false -- Vital for Ghostty ANSI sync
      vim.cmd("colorscheme base16-default-dark")

      local function apply_full_palette()
        -- Mapping all 15 Ghostty slots
        local black, red, green, yellow, blue, magenta, cyan, white = 0, 1, 2, 3, 4, 5, 6, 7
        local grey, b_red, b_green, b_yellow, b_blue, b_magenta, b_cyan, b_white = 8, 9, 10, 11, 12, 13, 14, 15

        local function set(group, fg, bg)
          vim.api.nvim_set_hl(0, group, {
            ctermfg = fg,
            ctermbg = bg or "none",
            force = true,
            bold = false,
            italic = false,
          })
        end

        -- 1. THE CODE CANVAS (Uses White/Grey)
        set("Normal", white)
        set("Comment", grey)
        set("LineNr", grey)
        set("NonText", grey)

        -- 2. THE SYNTAX SPECTRUM (Using 1-6)
        set("Keyword", magenta) -- return, if, else
        set("Statement", red) -- const, let, var
        set("Function", blue) -- function names
        set("String", green) -- "quoted text"
        set("Type", yellow) -- Classes and Types
        set("Operator", cyan) -- =, +, =>
        set("Identifier", b_white) -- Variables
        set("Constant", b_yellow) -- Hardcoded numbers/Booleans

        -- 3. REACT & WEB SPECIFICS
        set("@tag", red) -- <Section>
        set("@tag.delimiter", grey) -- < and >
        set("@tag.attribute", yellow) -- props
        set("@parameter", cyan) -- id, index, array
        set("Delimiter", white) -- { } [ ]

        -- 4. THE UI (Black-on-Color for Contrast)
        set("Visual", black, yellow) -- Black text on Yellow selection
        set("Search", black, orange)
        set("CursorLine", nil, black) -- Subtle dark bar for the line

        -- 5. EXPLORER (NeoTree)
        set("NeoTreeDirectoryName", blue)
        set("NeoTreeFileName", white)
        set("NeoTreeRootName", magenta)
        set("NeoTreeSymbolicLinkTarget", cyan)
      end

      -- DISABLE SEMANTIC TOKENS (The "Anti-Vanilla" Shield)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })

      apply_full_palette()

      -- Watchdog: keeps the colors from snapping back
      vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
        callback = function()
          vim.schedule(apply_full_palette)
        end,
      })
    end,
  },
}
