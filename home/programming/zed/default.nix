{
    lib,
    osConfig,
    pkgs,
    ...
}: {
    programs.zed-editor = {
        enable = true;

        userSettings = import ./settings.nix {inherit lib osConfig pkgs;};

        extensions = [
            # keep-sorted start
            "fish"
            "julia"
            "just"
            "just-ls"
            "latex"
            "nix"
            "toml"
            "typst"
            "vscode-icons"
            # keep-sorted end
        ];

        extraPackages = with pkgs; [
            # keep-sorted start
            alejandra
            nil
            nixd
            package-version-server
            rust-analyzer
            taplo-lsp
            texlab
            tinymist
            # keep-sorted end
        ];
    };

    stylix.targets.zed.enable = true;
}
