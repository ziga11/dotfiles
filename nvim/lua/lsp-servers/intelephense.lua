return {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_markers = { ".git", "composer.json" },

    settings = {
        intelephense = {
            telemetry = {
                enabled = false,
            },

            files = {
                exclude = {
                    "**/.git/**",
                    "**/.svn/**",
                    "**/.hg/**",
                    "**/CVS/**",
                    "**/.DS_Store/**",
                    "**/node_modules/**",
                    "**/bower_components/**",
                    "**/vendor/**/{Tests,tests}/**",
                    "**/.history/**",
                    "**/vendor/**/vendor/**",

                    "**/_ide_helper.php",
                    "**/_ide_helper_models.php",
                    "**/_ide_helpers.php",
                },
            },
        },
    },
}
