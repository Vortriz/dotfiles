{
    pkgs,
    ...
}: {
    programs.vscode = {
        enable = true;

        userSettings = {
            # use FiraCode ( to fix broken icons)
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

            # cleaner file explorer
            "workbench.tree.indent" = 12;

            # annoying confimation
            "explorer.confirmDragAndDrop" = false;
            "git.confirmSync" = false;

            # nix LSP
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
        };

        extensions = with pkgs.vscode-extensions; [
            # language packs et al
            james-yu.latex-workshop
            jnoortheen.nix-ide
            mikestead.dotenv
            mkhl.direnv
            ms-python.isort
            ms-python.python
            ms-python.vscode-pylance
            ms-toolsai.jupyter
            ms-toolsai.jupyter-renderers
            ms-toolsai.vscode-jupyter-cell-tags
            ms-toolsai.vscode-jupyter-slideshow
            nvarner.typst-lsp
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
            github.copilot
            github.copilot-chat
            donjayamanne.githistory
            ms-azuretools.vscode-docker
            ms-vscode-remote.remote-containers
            ms-vsliveshare.vsliveshare
            ritwickdey.liveserver
            rubymaniac.vscode-paste-and-indent
        ];
    };
}
