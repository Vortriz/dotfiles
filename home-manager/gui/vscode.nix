{
    pkgs,
    ...
}: {
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            # language packs et al
            bbenoist.nix
            james-yu.latex-workshop
            mikestead.dotenv
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
