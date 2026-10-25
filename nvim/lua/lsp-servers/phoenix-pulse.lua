return {
    cmd = {
        "node",
        "/usr/local/bin/phoenix-pulse-lsp",
        "--stdio",
    },
    filetypes = { "elixir", "heex", "eelixir", },
    root_markers = { "mix.exs", ".git", },
    init_options = {
        phoenixPulse = {
            useElixirParser = true,
            parserConcurrency = 5,
        },
    },
}
