{
    outputs,
    pkgs,
    lib,
    system,
    ...
}: {
    programs.zed-editor = rec {
        extensions = [
            # keep-sorted start
            "astro"
            "harper"
            "julia"
            "just"
            "latex"
            "nix"
            "qml"
            "ruff"
            "scss"
            "typst"
            "vscode-icons"
            # keep-sorted end
        ];

        extraPackages = with pkgs; [
            # keep-sorted start
            alejandra
            astro-language-server
            harper
            kdePackages.qtdeclarative
            nixd
            nodejs
            outputs.formatter.${system}
            package-version-server
            ruff
            rust-analyzer
            texlab
            tinymist
            tree-sitter-grammars.tree-sitter-scss
            # keep-sorted end
        ];

        userSettings = {
            auto_install_extensions = lib.attrsets.genAttrs extensions (_: false);
        };
    };
}
