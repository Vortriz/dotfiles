{
    unify.home = {pkgs, ...}: {
        programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
            # language packs et al

            # keep-sorted start
            charliermarsh.ruff
            james-yu.latex-workshop
            jnoortheen.nix-ide
            ms-python.python
            ms-toolsai.jupyter
            ms-toolsai.jupyter-renderers
            ms-toolsai.vscode-jupyter-cell-tags
            myriad-dreamin.tinymist
            nefrob.vscode-just-syntax
            shd101wyy.markdown-preview-enhanced
            yzhang.markdown-all-in-one
            # keep-sorted end

            # misc

            # keep-sorted start
            Google.gemini-cli-vscode-ide-companion
            donjayamanne.githistory
            github.copilot
            github.copilot-chat
            jock.svg
            mkhl.direnv
            ms-vsliveshare.vsliveshare
            ritwickdey.liveserver
            rubymaniac.vscode-paste-and-indent
            tomoki1207.pdf
            # keep-sorted end
        ];
    };
}
