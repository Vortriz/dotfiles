{ pkgs, inputs, ... }:

{
    home.packages = [ pkgs.vscode ];

    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
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
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons
            github.github-vscode-theme
            pkief.material-icon-theme
            zhuangtongfa.material-theme
            eamodio.gitlens
            antfu.slidev
            github.copilot
            github.copilot-chat
            ms-azuretools.vscode-docker
            ms-vscode-remote.remote-containers
            ms-vsliveshare.vsliveshare
            ritwickdey.liveserver
            rubymaniac.vscode-paste-and-indent
            

            # goessner.mdmath
            # mark-wiemer.vscode-autohotkey-plus-plus
            # ms-python.autopep8
            # ms-python.debugpy
            # monokai.theme-monokai-pro-vscode
            # glorwinger.nwscript
            # moshfeu.compare-folders
            # ms-edgedevtools.vscode-edge-devtools
        ];
    };
}
