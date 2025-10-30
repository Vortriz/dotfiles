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
            "modern-icons"
            "nix"
            "qml"
            "scss"
            "typst"
            # keep-sorted end
        ];

        extraPackages = with pkgs; [
            # keep-sorted start
            alejandra
            astro-language-server
            harper
            kdePackages.qtdeclarative
            nil
            nixd
            nodejs_latest
            outputs.formatter.${system}
            package-version-server
            ruff
            rust-analyzer
            texlab
            tinymist
            tree-sitter-grammars.tree-sitter-scss
            ty
            # keep-sorted end
        ];

        userSettings = {
            auto_install_extensions = lib.attrsets.genAttrs extensions (_: false);
        };
    };
}
