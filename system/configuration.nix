# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    imports = [
        # If you want to use modules your own flake exports (from modules/nixos):
        # outputs.nixosModules.example

        # Or modules from other flakes (such as nixos-hardware):
        # inputs.hardware.nixosModules.common-cpu-amd
        # inputs.hardware.nixosModules.common-ssd
        inputs.niri.nixosModules.niri

        # You can also split up your configuration and import pieces of it here:
        # ./users.nix

        # Import your generated (nixos-generate-config) hardware configuration
        ./hardware-configuration.nix

        # Using Home Manager as NixOS module
        ./hm-module.nix

        # Other imports
        ./core
        ./hardware
        ./programs
        ./services
    ];

    nixpkgs = {
        overlays = [
            # Add overlays your own flake exports (from overlays and pkgs dir):
            outputs.overlays.additions
            outputs.overlays.modifications

            # You can also add overlays exported from other flakes:
            # neovim-nightly-overlay.overlays.default

            # Or define it inline, for example:
            # (final: prev: {
            #     hi = final.hello.overrideAttrs (oldAttrs: {
            #         patches = [ ./change-hello-to-hi.patch ];
            #     });
            # })
        ];
        # Configure your nixpkgs instance
        config = {
            # Disable if you don't want unfree packages
            allowUnfree = true;
        };
    };

    nix = let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
        settings = {
            # Enable flakes and new 'nix' command
            experimental-features = "nix-command flakes";
            # Workaround for https://github.com/NixOS/nix/issues/9574
            nix-path = config.nix.nixPath;
            # Add myself to the trusted users
            trusted-users = [ "root" "vortriz" ];
        };
        # Opinionated: disable channels
        channel.enable = false;

        # Opinionated: make flake registry and nix path match flake inputs
        # registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        # nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    users.users = {
        vortriz = {
            isNormalUser = true;
            openssh.authorizedKeys.keys = [
                # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
            ];
            extraGroups = ["networkmanager" "wheel" "video"];
        };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";
}
