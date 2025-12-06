return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = "anthropic",
      },
    },
    adapters = {
      http = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "ANTHROPIC_API_KEY",
            },
          })
        end,
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ravitemer/mcphub.nvim"
  },
}
