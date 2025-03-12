return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Optional dependencies for better experience
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    "folke/lazydev.nvim",   -- Lua API development, replacing neodev
  },
  config = function()
    -- Setup lazydev first for Lua development
    require("lazydev").setup()

    -- Setup language servers
    local lspconfig = require("lspconfig")

    -- TypeScript/JavaScript
    lspconfig.ts_ls.setup({
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    })


    -- Lua
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- Golang
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    })

    -- Svelte
    lspconfig.svelte.setup({
      settings = {
        svelte = {
          plugin = {
            html = {
              completions = {
                enable = true,
                emmet = true,
              },
            },
            svelte = {
              diagnostics = {
                enable = true,
              },
              compilerWarnings = {
                css_unused_selector = "ignore",
              },
              format = {
                enable = true,
              },
            },

          },
        },
      },
    })

    -- HTML
    lspconfig.html.setup({
      settings = {
        html = {
          format = {
            indentInnerHtml = false,
            wrapLineLength = 100,
            wrapAttributes = "auto",
            templating = true,
            unformatted = nil,
          },
          hover = {
            documentation = true,
            references = true,
          },
          validate = {
            scripts = true,
            styles = true,
          },
          suggest = {
            html5 = true,
          },
          autoClosingTags = true,
          mirrorCursorOnMatchingTag = true,
        },
      },
      capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
            },
          },
        },
      },
    })

    -- Python
    lspconfig.pyright.setup({
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
            typeCheckingMode = "basic", -- Can be "off", "basic", or "strict"
          }
        }
      }
    })
    lspconfig.ruff.setup({
      init_options = {
        settings = {
          -- Ruff settings
          lint = {
            run = "onSave",
          },
          format = {
            args = {},
          },
        }
      }
    })

    -- Global mappings
    vim.keymap.set('n', '<space>l', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
  end,
}
