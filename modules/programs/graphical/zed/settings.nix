{
    unify.home = {
        lib,
        config,
        pkgs,
        ...
    }: let
        fontName = lib.mkForce config.stylix.fonts.monospace.name;
        fontSize = lib.mkForce 18;
    in {
        programs.zed-editor = {
            mutableUserSettings = false;

            userSettings = {
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
                            arguments = ["fmt" "--" "--stdin" "{buffer_path}"];
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
                load_direnv = "direct";
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
                    detect_venv.on.activate_script = "fish";
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
        };
    };
}
