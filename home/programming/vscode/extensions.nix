{pkgs, ...}:
with pkgs.vscode-marketplace;
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
        rust-lang.rust-analyzer
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
    ])
