{
    inputs,
    lib,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) system;
in {
    imports = [inputs.zed-extensions.homeManagerModules.default];

    programs.zed-editor = {
        enable = true;

        userSettings = import ./settings.nix {inherit lib osConfig pkgs;};
        userKeymaps = import ./keymap.nix;

        extraPackages =
            (with pkgs; [
                # keep-sorted start
                alejandra
                nil
                nixd
                package-version-server
                rust-analyzer
                texlab
                tinymist
                # keep-sorted end
            ])
            ++ (with inputs; [
                mcp-nixos.packages.${system}.default
            ]);
    };

    programs.zed-editor-extensions = {
        enable = true;
        packages = with pkgs.zed-extensions; [
            # keep-sorted start
            julia
            just
            latex
            nix
            ruff
            tombi
            typst
            vscode-icons
            # keep-sorted end
        ];
    };

    stylix.targets.zed.enable = true;
}
