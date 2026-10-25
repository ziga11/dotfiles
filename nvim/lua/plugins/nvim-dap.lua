return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            dap.adapters.coreclr = {
                type = 'executable',
                command = '/home/ziga/.local/share/nvim/mason/bin/netcoredbg',
                args = { '--interpreter=vscode' }
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },

            }

            dap.adapters.elixir = {
                type = 'executable',
                command = '/home/ziga/.local/share/nvim/mason/bin/elixir-ls-debugger',
                args = {}
            }

            dap.configurations.elixir = {
                {
                    type = 'elixir',
                    name = 'Run Elixir App',
                    request = 'launch',
                    program = "${file}",
                    projectDir = "${workspaceFolder}",
                },
            }

            dap.adapters.python = {
                type = 'executable',
                command = 'python3',
                args = { '-m', 'debugpy.adapter' },
            }

            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function()
                        return '/usr/bin/python'
                    end,
                },
            }

            dap.adapters.go = {
                type = 'executable',
                command = 'dlv',
                args = { 'dap', '-l', '127.0.0.1:${port}' },
            }

            dap.configurations.go = {
                {
                    type = 'go',
                    name = 'Debug',
                    request = 'launch',
                    program = "${file}",
                },
                {
                    type = 'go',
                    name = 'Debug test',
                    request = 'launch',
                    mode = 'test',
                    program = "${file}",
                },

            }

            dap.configurations.sh = {
                {
                    type = 'bashdb',
                    request = 'launch',
                    name = "Launch file",
                    showDebugOutput = true,
                    pathBashdb =
                    '/home/ziga/.local/share/nvim/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
                    pathBashdbLib = '/home/ziga/.local/share/nvim/mason/packages/bash-debug-adapter/extension/bashdb_dir',
                    trace = true,
                    file = "${file}",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    pathCat = "cat",
                    pathBash = "/bin/bash",
                    pathMkfifo = "mkfifo",
                    pathPkill = "pkill",
                    args = function()
                        local args_str = vim.fn.input('Arguments for your script: ')
                        return vim.split(args_str, " +")
                    end,
                    env = {},
                    terminalKind = "integrated",
                }

            }
            dap.adapters.bashdb = {
                type = 'executable',
                command = '/home/ziga/.local/share/nvim/mason/bin/bash-debug-adapter',
                args = {},
            }
        end,
    },
}
