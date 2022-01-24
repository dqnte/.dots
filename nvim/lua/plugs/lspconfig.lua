Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local buf_keymap = vim.api.nvim_buf_set_keymap
  buf_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local function on_attach(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local function configure_server(server_name, opts)
  local lsp_installer_servers = require "nvim-lsp-installer.servers"
  local active, server = lsp_installer_servers.get_server(server_name)

  if active then
    server:on_ready(function()
	    server:setup(opts)
    end)
  else
    if not server:is_installed() then
      server:install()
    end
  end
end

local function configure_lsp()
  require "lspconfig"

  configure_server("sumneko_lua",  {
	on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        },
        workspace = {
		  library = {
			[vim.fn.expand("$VIMRUNTIME/lua")] = true,
			[vim.fn.stdpath("config") .. "/lua"] = true,
		  }
		}
      }
	}
  })
  -- configure_server("remark_ls", {
  --   on_attach = on_attach,
  --   capabilities = capabilities
  -- })
end

local function configure_diagnostics()
    local signs = {
      { name = "DiagnosticSignError", text = "裸" },
      { name = "DiagnosticSignWarn", text = "勞" },
      { name = "DiagnosticSignHint", text = "勞" },
      { name = "DiagnosticSignInfo", text = " " },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, {
        texthl = sign.name,
        text = sign.text,
        numhl = "" })
    end

    local config = {
      virtual_text = false,
      signs = {
        active = signs,
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        -- border = "single",
        guibg = "red",
        source = "always",
        header = "",
        prefix = "",
      },
    }
  vim.diagnostic.config(config)
end

vim.loaded.start_lsp = function()
  configure_lsp()
  configure_diagnostics()
end
