return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = '[D]iagnostic [O]pen' })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { desc = '[D]iagnostic goto next' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { desc = '[D]iagnostic goto prev' })
      vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Add [D]iagnostic to [L]ocation list' })

      -- Gets run when LSP attaches to a particular buffer
      --
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local vmap = function(keys, func, desc)
            vim.keymap.set({ 'n', 'v' }, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local ivmap = function(keys, func, desc)
            vim.keymap.set({ 'n', 'v', 'i' }, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local tb = require 'telescope.builtin'
          map('gd', tb.lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gr', tb.lsp_references, '[G]oto [R]eferences')
          map('gI', tb.lsp_implementations, '[G]oto [I]mplementations')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          ivmap('<C-k>', vim.lsp.buf.signature_help, 'Hover signature')

          local list_ws_dirs = function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end

          map('<leader>ds', tb.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', tb.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd dir')
          map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove dir')
          map('<leader>wl', list_ws_dirs, '[W]orkspace [L]ist dirs')

          local async_format = function()
            vim.lsp.buf.format { async = true }
          end

          -- Refactorings
          map('<leader>rn', vim.lsp.buf.rename, '[R]efactor: Re[n]ame')
          map('<leader>rf', async_format, '[R]efactor: [F]ormat')
          vmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Omnicompletion
          vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- highlight references of the word under a cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            -- After a while highlights are displayed
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            -- when moved, highlights will be cleared
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {},
        rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              format = {
                enable = true,
                indent_style = 'space',
                indent_size = '2',
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- or: library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- diagnostics = {disable = {'missing-fields'}},
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
