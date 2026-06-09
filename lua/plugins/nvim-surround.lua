return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy", -- Loads the plugin in the background after Neovim starts up
  config = function()
    require("nvim-surround").setup {
      -- Add any custom configuration options here.
      -- Leave empty to use the default settings.
    }
  end,
}
