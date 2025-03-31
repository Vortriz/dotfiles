{
    pkgs,
    ...
}: {
    programs.vscode = {
        enable = true;

        profiles.default = {
            userSettings = {
                "[nix]" = {
                    "editor.detectIndentation" = false;
                    "editor.tabSize" = 4;
                    "editor.defaultFormatter" = "kamadorueda.alejandra";
                    "editor.formatOnPaste" = true;
                    "editor.formatOnSave" = true;
                    "editor.formatOnType" = false;
                };
                "[typst]" = {
                    "editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
                };

                "alejandra.program" = "alejandra";

                "diffEditor.ignoreTrimWhitespace" = false;
                "direnv.restart.automatic" = true;

                "editor.detectIndentation" = false;
                "editor.indentSize" = "tabSize";
                "editor.insertSpaces" = true;
                "editor.tabSize" = 4;

                "explorer.confirmDragAndDrop" = false;
                "files.trimTrailingWhitespace" = true;
                "git.confirmSync" = false;
                "github.copilot.enable" = { "shellscript" = false; };

                "julia.enableTelemetry" = true;
                "julia.symbolCacheDownload" = true;

                "nix.enableLanguageServer" = true;
                "nix.serverPath" = "nixd";

                "terminal.integrated.commandsToSkipShell" = [ "language-julia.interrupt" ];
                "terminal.integrated.defaultProfile.linux" = "fish";
                "terminal.integrated.fontFamily" = "'FiraCode Nerd Font Mono'";

                "tinymist.formatterIndentSize" = 4;
                "window.zoomLevel" = 1.2;

                "workbench.colorTheme" = "Stylix";
                "workbench.tree.indent" = 12;
            };

            extensions = with pkgs.vscode-extensions; [
                # language packs et al
                james-yu.latex-workshop
                jnoortheen.nix-ide
                julialang.language-julia
                kamadorueda.alejandra
                mikestead.dotenv
                mkhl.direnv
                ms-python.isort
                ms-python.python
                ms-python.vscode-pylance
                ms-toolsai.jupyter
                ms-toolsai.jupyter-renderers
                ms-toolsai.vscode-jupyter-cell-tags
                ms-toolsai.vscode-jupyter-slideshow
                myriad-dreamin.tinymist
                nefrob.vscode-just-syntax
                shd101wyy.markdown-preview-enhanced
                tamasfe.even-better-toml
                yzhang.markdown-all-in-one

                # themes et al
                catppuccin.catppuccin-vsc
                catppuccin.catppuccin-vsc-icons
                github.github-vscode-theme
                pkief.material-icon-theme
                zhuangtongfa.material-theme

                # misc
                antfu.slidev
                donjayamanne.githistory
                github.copilot
                github.copilot-chat
                jock.svg
                ms-azuretools.vscode-docker
                ms-vscode-remote.remote-containers
                ms-vsliveshare.vsliveshare
                ritwickdey.liveserver
                rubymaniac.vscode-paste-and-indent
                tomoki1207.pdf
            ];
        };
    };

    home.file.".vscode/argv.json".text = builtins.toJSON {
        enable-crash-reporter = false;
        password-store = "gnome-libsecret";
    };

    stylix.targets.vscode = {
        enable = true;
        profileNames = [ "default" ];
    };
}
