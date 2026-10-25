local M = {}

function M.artisan()
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    vim.fn.jobstart({ "php", "artisan", "list", "--format=json" }, {
        cwd = vim.fn.getcwd(),
        stdout_buffered = true,
        on_stdout = function(_, data)
            if not data or #data == 0 then
                return
            end

            local output = table.concat(data, "\n")
            local ok, result = pcall(vim.json.decode, output)

            if not ok or not result.commands then
                vim.schedule(function()
                    vim.notify("Could not parse Artisan command list", vim.log.levels.ERROR)
                end)
                return
            end

            local entries = {}
            for _, command in ipairs(result.commands) do
                table.insert(entries, {
                    value = command.name,
                    display = command.name .. " - " .. (command.description or ""),
                    ordinal = command.name .. " " .. (command.description or ""),
                })
            end

            vim.schedule(function()
                builtin.find_files({
                    prompt_title = "Artisan commands",
                    finder = require("telescope.finders").new_table({
                        results = entries,
                        entry_maker = function(entry)
                            return entry
                        end,
                    }),
                    sorter = require("telescope.config").values.generic_sorter({}),
                    attach_mappings = function(prompt_bufnr, map)
                        local function run()
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)

                            if selection then
                                vim.cmd("Artisan " .. selection.value)
                            end
                        end

                        map("i", "<CR>", run)
                        map("n", "<CR>", run)
                        return true
                    end,
                })
            end)
        end,
    })
end

return M
