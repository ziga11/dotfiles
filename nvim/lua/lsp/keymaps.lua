local M = {}

local function uniqueifySuggestions(opts)
    local seen, items = {}, {}

    for _, item in ipairs(opts.items) do
        local key = item.filename .. ":" .. item.lnum

        if not seen[key] then
            seen[key] = true
            table.insert(items, item)
        end
    end

    vim.fn.setqflist({}, " ", {
        title = opts.title,
        items = items,
    })

    if #items == 1 then
        vim.cmd("silent cfirst")
    else
        require("telescope.builtin").quickfix()
    end
end

function M.setup(bufnr)
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, {
            buffer = bufnr,
            desc = "LSP: " .. desc,
        })
    end

    map("gd", function()
        vim.lsp.buf.definition({ on_list = uniqueifySuggestions })
    end, "[G]oto [D]efinition")

    local telescope = require("telescope.builtin")

    map("gr", telescope.lsp_references, "[G]oto [R]eferences")
    map("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", telescope.lsp_type_definitions, "Type [D]efinition")
    map("<leader>ss", telescope.lsp_document_symbols, "[S]earch [S]ymbols")
    map("<leader>sw", telescope.lsp_dynamic_workspace_symbols, "[S]earch [W]orkspace")

    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

return M
