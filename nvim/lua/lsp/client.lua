local M = {}

function M.setup(client, bufnr)
    if client.name ~= "phpactor" then return end

    client.server_capabilities.completionProvider = nil
    client.server_capabilities.hoverProvider = nil
    client.server_capabilities.definitionProvider = nil
    client.server_capabilities.referencesProvider = nil

    client.handlers["textDocument/publishDiagnostics"] = function() end

    vim.diagnostic.reset(
        vim.lsp.diagnostic.get_namespace(client.id),
        bufnr
    )
end

return M
