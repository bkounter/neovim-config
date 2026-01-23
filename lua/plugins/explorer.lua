return {
  -- Keep Neo-tree disabled
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        -- This ensures the picker layout doesn't try to force a "solid" style
        win = {
          input = { keys = { ["<Esc>"] = "close" } },
          list = { keys = { ["<Esc>"] = "close" } },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local groups = {
            -- The main "Snacks" UI groups
            "SnacksNormal",
            "SnacksNormalNC",
            "SnacksPicker",
            "SnacksPickerBorder",
            "SnacksPickerList",
            "SnacksPickerInput",
            -- General Neovim Float groups (often used as fallbacks)
            "NormalFloat",
            "FloatBorder",
            "FloatTitle",
          }
          for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
          end
        end,
      })
    end,
  },
}
