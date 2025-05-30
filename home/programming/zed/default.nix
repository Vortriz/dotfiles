{
    inputs,
    lib,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) system;
in {
    programs.zed-editor = {
        enable = true;

        userSettings = import ./settings.nix {inherit lib osConfig pkgs;};
        userKeymaps = import ./keymap.nix;

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

        extraPackages =
            (with pkgs; [
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
            ])
            ++ (with inputs; [
                mcp-nixos.packages.${system}.default
            ]);
    };

    stylix.targets.zed.enable = true;
}
