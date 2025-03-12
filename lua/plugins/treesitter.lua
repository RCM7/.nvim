return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
          "html",
          "bash",
          "javascript",
          "typescript",
          "go",
          "svelte",
          "hcl",
          "json",
          "yaml",
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "sql",
          "hjson",
          "scss",
          "terraform"
        },
        sync_install = false,
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true }
      })
    end
  }
}
