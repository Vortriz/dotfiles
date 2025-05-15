{
    lib,
    osConfig,
    pkgs,
    ...
}: {
    programs.zed-editor = {
        enable = true;

        userSettings = import ./settings.nix {inherit lib osConfig;};

        extensions = [
            "nix"
            "just"
            "just-ls"
            "latex"
            "typst"
            "vscode-icons"
        ];

        extraPackages = with pkgs; [
            nixd
        ];
    };

    stylix.targets.zed.enable = true;
}
