{pkgs, ...}:
with pkgs.vscode-extensions; [
    # language packs et al

    # keep-sorted start
    james-yu.latex-workshop
    jnoortheen.nix-ide
    julialang.language-julia
    ltex-plus.vscode-ltex-plus
    mikestead.dotenv
    ms-python.isort
    ms-python.python
    ms-python.vscode-pylance
    ms-toolsai.jupyter
    ms-toolsai.jupyter-renderers
    ms-toolsai.vscode-jupyter-cell-tags
    myriad-dreamin.tinymist
    nefrob.vscode-just-syntax
    rust-lang.rust-analyzer
    shd101wyy.markdown-preview-enhanced
    tamasfe.even-better-toml
    yzhang.markdown-all-in-one
    # keep-sorted end

    # misc

    # keep-sorted start
    donjayamanne.githistory
    github.copilot
    github.copilot-chat
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
