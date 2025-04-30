{
    inputs,
    pkgs,
    ...
}: {
    nixpkgs.overlays = [inputs.nix-vscode-extensions.overlays.default];

    programs.vscode = {
        enable = true;

        profiles.default = {
            userSettings = {
                # keep-sorted start block=yes
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
                # keep-sorted end
            };

            extensions = with pkgs.vscode-marketplace;
                [
                    # language packs et al

                    # keep-sorted start
                    james-yu.latex-workshop
                    jnoortheen.nix-ide
                    julialang.language-julia
                    mikestead.dotenv
                    ms-python.isort
                    ms-python.python
                    ms-python.vscode-pylance
                    ms-toolsai.jupyter-renderers
                    ms-toolsai.vscode-jupyter-cell-tags
                    myriad-dreamin.tinymist
                    nefrob.vscode-just-syntax
                    shd101wyy.markdown-preview-enhanced
                    tamasfe.even-better-toml
                    yzhang.markdown-all-in-one
                    # ltex-plus.vscode-ltex-plus # https://github.com/nix-community/nix-vscode-extensions/issues/123
                    # keep-sorted end

                    # misc

                    # keep-sorted start
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
                    # keep-sorted end
                ]
                ++ (with pkgs.vscode-marketplace-release; [
                    # keep-sorted start
                    github.copilot
                    github.copilot-chat
                    ms-toolsai.jupyter
                    # keep-sorted end
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
