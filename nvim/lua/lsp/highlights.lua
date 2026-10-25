local M = {}

function M.setup(client, bufnr)
    if not client.supports_method("textDocument/documentHighlight") then
        return
    end

    local group = vim.api.nvim_create_augroup("lsp-document-highlight-" .. bufnr, { clear = true })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

return M
