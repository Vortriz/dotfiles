{
    config,
    outputs,
    pkgs,
    ...
}: let
    inherit (config.var) username;
in {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ../secrets/agenix.nix
        ./hardware-configuration.nix
        ./hm-module.nix
        ./services.nix
        ./settings.nix
        ./variables.nix

        ./programs
        # keep-sorted end
    ];

    nixpkgs = {
        overlays = [
            outputs.overlays.additions
            outputs.overlays.modifications
        ];

        config.allowUnfree = true;
    };

    nix = {
        settings = {
            # Enable flakes and new 'nix' command
            experimental-features = "nix-command flakes";

            # Workaround for https://github.com/NixOS/nix/issues/9574
            nix-path = config.nix.nixPath;

            # Add myself to the trusted users
            trusted-users = ["root" username];

            # Add extra Caches
            substituters = [
                "https://cosmic.cachix.org/"
                "https://yazi.cachix.org"
            ];
            trusted-public-keys = [
                "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
            ];
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
                # Add your SSH public key(s) here, if you plan on using SSH to connect
            ];
            extraGroups = ["networkmanager" "wheel" "video" "aria2"];
            shell = pkgs.fish;
        };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";
}
