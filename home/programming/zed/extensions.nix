{pkgs, ...}: {
    programs.zed-editor = {
        extensions = [
            # keep-sorted start
            "julia"
            "just"
            "latex"
            "ltex"
            "nix"
            "ruff"
            "scss"
            "typst"
            "vscode-icons"
            # keep-sorted end
        ];

        extraPackages = with pkgs; [
            # keep-sorted start
            alejandra
            ltex-ls-plus
            nixd
            package-version-server
            ruff
            rust-analyzer
            texlab
            tinymist
            tree-sitter-grammars.tree-sitter-scss
            # keep-sorted end
        ];
    };
}
