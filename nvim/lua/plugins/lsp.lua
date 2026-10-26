return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "j-hui/fidget.nvim",
            config = function()
                require("fidget").setup({})
            end,
        },
        {
            "folke/neodev.nvim",
            config = function()
                require("neodev").setup({})
            end,
        },
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        local lsp_keymaps = require("lsp.keymaps")
        local lsp_highlights = require("lsp.highlights")
        local lsp_client = require("lsp.client")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", {
                clear = true,
            }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)

                lsp_keymaps.setup(event.buf)

                if client then
                    lsp_highlights.setup(client, event.buf)
                    lsp_client.setup(client, event.buf)
                end
            end,
        })

        local servers = {
            phoenix_pulse = "phoenix-pulse",
            glint = "glint",
            intelephense = "intelephense",
        }

        for server, module in pairs(servers) do
            vim.lsp.config(server, vim.tbl_deep_extend(
                "force",
                {},
                require("lsp-servers." .. module),
                { capabilities = capabilities }
            ))
        end

        mason.setup()
        mason_lspconfig.setup({
            ensure_installed = {
                -- WEB - HTML, CSS, JS/TS
                "html",
                "emmet_language_server",
                "cssls",
                "ts_ls",
                "lua_ls",
                "eslint",
                "glint",

                "jsonls",
                "lexical",

                --PHP
                "phpactor",
                "intelephense",
            },
        })
    end
}
