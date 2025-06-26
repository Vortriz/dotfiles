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
            # keep-sorted end
        ];
    };
}
