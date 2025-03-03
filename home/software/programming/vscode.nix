{
    pkgs,
    ...
}: {
    programs.vscode = {
        enable = true;

        profiles.default = {
            userSettings = {
                # use FiraCode (to fix broken icons)
                "terminal.integrated.fontFamily" = "'FiraCode Nerd Font Mono'";

                # because this is the only sane thing
                "editor.detectIndentation" = false;
                "editor.tabSize" = 4;
                "[nix]" = {
                    "editor.detectIndentation" = false;
                    "editor.tabSize" = 4;
                };

                # clean files
                "files.trimTrailingWhitespace" = true;

                # better diffs
                "diffEditor.ignoreTrimWhitespace" = false;

                # cleaner file explorer
                "workbench.tree.indent" = 12;

                # zoom slightly
                "window.zoomLevel" = 1.2;

                # annoying confimation
                "explorer.confirmDragAndDrop" = false;
                "git.confirmSync" = false;

                # nix LSP
                "nix.enableLanguageServer" = true;
                "nix.serverPath" = "nixd";

                # fix annoying warning
                "workbench.colorTheme" = "Stylix";

                # julia
                "julia.symbolCacheDownload" = true;
                "terminal.integrated.commandsToSkipShell" = [
                "language-julia.interrupt"
                ];
                "julia.enableTelemetry" = true;


                # typst
                "[typst]" = {
                    "editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
                };

                # copilot
                "github.copilot.enable" = {
                    "shellscript" = false;
                };

                # use fish shell by default
                "terminal.integrated.defaultProfile.linux" = "fish";
            };

            extensions = with pkgs.vscode-extensions; [
                # language packs et al
                james-yu.latex-workshop
                jnoortheen.nix-ide
                julialang.language-julia
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
                shd101wyy.markdown-preview-enhanced
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

    stylix.targets.vscode.enable = true;
}
