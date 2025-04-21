{
    inputs,
    osConfig,
    outputs,
    ...
}: let
    inherit (osConfig.var) username;
in {
    imports = [
        # keep-sorted start by_regex=(^inputs|\.nix$) prefix_order=inputs,./
        inputs.misumisumi-dotfiles.homeManagerModules.zotero
        inputs.scientific-fhs.nixosModules.default
        inputs.sherlock.homeManagerModules.default
        inputs.walker.homeManagerModules.default
        ./stylix.nix
        ./xdg-portal.nix

        ../scripts
        ./graphical
        ./programming
        ./terminal
        ./wayland
        # keep-sorted end
    ];

    nixpkgs = {
        overlays = [
            # keep-sorted start by_regex=^(inputs)
            inputs.nix-vscode-extensions.overlays.default

            outputs.overlays.additions
            outputs.overlays.modifications
            # keep-sorted end
        ];

        config.allowUnfree = true;
    };

    home = {
        inherit username;
        homeDirectory = "/home/" + username;
    };

    programs.home-manager.enable = true;

    systemd.user = {
        # Nicely reload system units when changing configs
        startServices = "sd-switch";
    };

    # For setting default applications
    xdg.mimeApps.enable = true;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
}
