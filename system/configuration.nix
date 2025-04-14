{
    config,
    inputs,
    lib,
    outputs,
    ...
}: let
    username = config.var.username;
in {
    imports = [
        # If you want to use modules your own flake exports (from modules/nixos):
        # outputs.nixosModules.example

        # Or modules from other flakes (such as nixos-hardware):
        # inputs.hardware.nixosModules.common-cpu-amd
        # inputs.hardware.nixosModules.common-ssd
        inputs.agenix.nixosModules.default
        inputs.niri.nixosModules.niri
        inputs.nixos-cosmic.nixosModules.default
        inputs.stylix.nixosModules.stylix

        # Import your generated (nixos-generate-config) hardware configuration
        ./hardware-configuration.nix

        # Using Home Manager as NixOS module
        ./hm-module.nix

        # Other imports
        ./programs

        ./services.nix
        ./settings.nix
        ./shell.nix
        ./variables.nix

        ../secrets/agenix.nix
    ];

    nixpkgs = {
        overlays = [
            # Add overlays your own flake exports (from overlays and pkgs dir):
            outputs.overlays.additions
            outputs.overlays.modifications

            # You can also add overlays exported from other flakes:
            # neovim-nightly-overlay.overlays.default
            inputs.niri.overlays.niri
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
            trusted-users = ["root" username];
            # Add extra Caches
            substituters = ["https://cosmic.cachix.org/" "https://yazi.cachix.org"];
            trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="];
        };
        # Opinionated: disable channels
        channel.enable = false;

        # Opinionated: make flake registry and nix path match flake inputs
        # registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        # nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    users.users = {
        ${username} = {
            isNormalUser = true;
            openssh.authorizedKeys.keys = [
                # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
            ];
            extraGroups = ["networkmanager" "wheel" "video" "aria2"];
        };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";
}
