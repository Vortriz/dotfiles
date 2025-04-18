{pkgs, ...}: {
    programs.vscode = {
        enable = true;

        profiles.default = {
            userSettings = {
                "[nix]" = {
                    "editor.detectIndentation" = false;
                    "editor.tabSize" = 4;
                };
                "[typst]" = {
                    "editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
                };

                "diffEditor.ignoreTrimWhitespace" = false;
                "direnv.restart.automatic" = true;

                "editor.detectIndentation" = false;
                "editor.indentSize" = "tabSize";
                "editor.insertSpaces" = true;
                "editor.tabSize" = 4;

                "explorer.confirmDragAndDrop" = false;
                "files.trimTrailingWhitespace" = true;
                "git.confirmSync" = false;
                "github.copilot.enable" = {"shellscript" = false;};

                "julia.enableTelemetry" = true;
                "julia.symbolCacheDownload" = true;

                "nix.enableLanguageServer" = true;
                "nix.serverPath" = "nixd";

                "terminal.integrated.commandsToSkipShell" = ["language-julia.interrupt"];
                "terminal.integrated.defaultProfile.linux" = "fish";
                "terminal.integrated.fontFamily" = "'FiraCode Nerd Font Mono'";

                "tinymist.formatterIndentSize" = 4;
                "window.zoomLevel" = 1.2;

                "workbench.colorTheme" = "Stylix";
                "workbench.tree.indent" = 12;
            };

            extensions = with pkgs.vscode-marketplace;
                [
                    # language packs et al
                    james-yu.latex-workshop
                    jnoortheen.nix-ide
                    julialang.language-julia
                    mikestead.dotenv

                    ms-python.isort
                    ms-python.python
                    ms-python.vscode-pylance
                    ms-toolsai.jupyter
                    ms-toolsai.jupyter-renderers
                    ms-toolsai.vscode-jupyter-cell-tags
                    myriad-dreamin.tinymist
                    nefrob.vscode-just-syntax
                    shd101wyy.markdown-preview-enhanced
                    tamasfe.even-better-toml
                    yzhang.markdown-all-in-one

                    # misc
                    antfu.slidev
                    donjayamanne.githistory
                    jock.svg
                    mkhl.direnv
                    ms-azuretools.vscode-docker
                    ms-vscode-remote.remote-containers
                    ms-vsliveshare.vsliveshare
                    ritwickdey.liveserver
                    rubymaniac.vscode-paste-and-indent
                    tomoki1207.pdf
                ]
                ++ (with pkgs.vscode-marketplace-release; [
                    github.copilot
                    github.copilot-chat
                ]);
        };
    };

    home.file.".vscode/argv.json".text = builtins.toJSON {
        enable-crash-reporter = false;
        password-store = "gnome-libsecret";
    };

    stylix.targets.vscode = {
        enable = true;
        profileNames = ["default"];
    };
}
