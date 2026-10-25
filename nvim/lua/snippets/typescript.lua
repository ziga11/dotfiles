local ls = require("luasnip")
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node

ls.add_snippets("typescript", {
    ls.snippet("forof", {
        ls.text_node("for (const "),
        ls.insert_node(1, "item"),
        ls.text_node(" of "),
        ls.insert_node(2, "items"),
        ls.text_node({ ") {", "\t" }),
        ls.insert_node(0),
        ls.text_node({ "", "}" }),
    }),
})

local function get_next_loop_var()
    local buf_text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    if not buf_text:find("let i") then
        return "i"
    elseif not buf_text:find("let j") then
        return "j"
    else
        return "k"
    end
end

ls.add_snippets("typescript", {
    ls.snippet("fori", {
        t("for (let "),
        d(1, function()
            return sn(nil, i(1, get_next_loop_var()))
        end, {}),
        t(" = 0; "),
        ls.insert_node(2, "index"),
        t(" < "),
        ls.insert_node(3, "items"),
        t(".length; "),
        d(4, function(args)
            return sn(nil, t(args[1][1] .. "++"))
        end, { 1 }),
        t({ ") {", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
})
