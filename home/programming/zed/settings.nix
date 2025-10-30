{
    lib,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) monospaceFontName;
    inherit (osConfig.defaults) shell;

    fontName = lib.mkForce monospaceFontName;
    fontSize = lib.mkForce 18;
in {
    programs.zed-editor.userSettings = {
        # keep-sorted start block=yes
        agent = {
            default_model = {
                provider = "copilot_chat";
                model = "gpt-4.1";
            };
        };
        auto_update = false;
        buffer_font_family = fontName;
        buffer_font_size = fontSize;
        context_servers = {
            nixos = {
                source = "custom";
                command = lib.getExe pkgs.mcp-nixos;
                args = [];
            };
        };
        cursor_shape = "bar";
        features.edit_prediction_provider = "copilot";
        git.inline_blame.enabled = false;
        icon_theme = "Modern Icons (Dark)";
        languages = {
            Nix = {
                format_on_save = "on";
                language_servers = ["nixd" "!nil"];
                formatter.external = {
                    command = "nix";
                    arguments = ["fmt"];
                };
            };
            Python = {
                format_on_save = "on";
                code_actions_on_format = {
                    "source.organizeImports.ruff" = true;
                    "source.fixAll.ruff" = true;
                };
                language_servers = ["ruff" "ty" "!basedpyright"];
            };
        };
        lsp =
            ([
                # keep-sorted start
                "astro-language-server"
                "nixd"
                "package-version-server"
                "rust-analyzer"
                "tailwindcss-language-server"
                "texlab"
                "tinymist"
                # keep-sorted end
            ]
            |> map (name: {
                ${name}.binary = {
                    path = lib.getExe pkgs.${name};
                };
            })
            |> lib.mergeAttrsList)
            // {
                # keep-sorted start block=yes
                astro-language-server.binary = {
                    path = lib.getExe pkgs.astro-language-server;
                    arguments = ["--stdio"];
                };
                harper.binary = {
                    path = lib.getExe pkgs.harper;
                    arguments = ["--stdio"];
                };
                qml.binary = {
                    path = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls";
                    arguments = ["-E"];
                };
                ruff.binary = {
                    path = lib.getExe pkgs.ruff;
                    arguments = ["server"];
                };
                tailwindcss-language-server.binary = {
                    path = lib.getExe pkgs.tailwindcss-language-server;
                    arguments = ["--stdio"];
                };
                # keep-sorted end
            };
        minimap = {
            show = "always";
            thumb = "always";
        };
        tab_size = 4;
        tabs = {
            file_icons = true;
            git_status = true;
        };
        terminal = {
            detect_venv.on.activate_script = "${lib.getName shell}";
            cursor_shape = "bar";
            toolbar.breadcrumbs = false;
            line_height = "comfortable";
        };
        ui_font_family = fontName;
        ui_font_size = fontSize;
        unnecessary_code_fade = 0.5;
        use_smartcase_search = true;
        # keep-sorted end
    };
}
