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
            version = "2";
            default_model = {
                provider = "copilot_chat";
                model = "gpt-4.1";
            };
        };
        auto_update = false;
        buffer_font_family = fontName;
        buffer_font_size = fontSize;
        # context_servers = {
        #     nixos = {
        #         command = {
        #             path = "mcp-nixos";
        #             args = [];
        #             env = {};
        #         };
        #         settings = {};
        #     };
        # };
        cursor_shape = "bar";
        features.edit_prediction_provider = "copilot";
        git.inline_blame.enabled = false;
        icon_theme = "VSCode Icons (Dark)";
        languages = {
            Nix = {
                language_servers = ["nixd" "!nil"];
                formatter.external = {
                    command = "nix";
                    arguments = ["fmt"];
                };
            };
            Python = {
                language_servers = ["pyright" "ruff" "!pylsp"];
                format_on_save = "on";
                formatter = [
                    {
                        code_actions = {
                            "source.fixAll.ruff" = true;
                            "source.organizeImports.ruff" = true;
                        };
                    }
                    {
                        language_server.name = "ruff";
                    }
                ];
            };
        };
        lsp =
            [
                # keep-sorted start
                "ltex-ls-plus"
                "nixd"
                "package-version-server"
                "rust-analyzer"
                "texlab"
                "tinymist"
                # keep-sorted end
            ]
            |> map (name: {
                ${name}.binary = {
                    path_lookup = true;
                    path = lib.getExe pkgs.${name};
                };
            })
            |> lib.mergeAttrsList;
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
        };
        toolbar.title = true;
        ui_font_family = fontName;
        ui_font_size = fontSize;
        unnecessary_code_fade = 0.5;
        use_smartcase_search = true;
        # keep-sorted end
    };
}
