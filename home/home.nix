{
    osConfig,
    outputs,
    ...
}: let
    inherit (osConfig.var) username;
in {
    imports = [
        # keep-sorted start by_regex=\.nix$
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
            outputs.overlays.additions
            outputs.overlays.modifications
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
