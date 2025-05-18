{
    config,
    inputs,
    outputs,
    ...
}: let
    inherit (config.var) username shell;
in {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ../secrets/agenix.nix
        ./hardware-configuration.nix
        ./hm-module.nix
        ./services.nix
        ./settings.nix
        ./variables.nix

        ../modules/nixos
        ./programs
        # keep-sorted end
    ];

    nixpkgs = {
        overlays = [
            outputs.overlays.additions
            outputs.overlays.modifications

            # keep-sorted start
            inputs.nix-vscode-extensions.overlays.default
            #keep-sorted end
        ];

        config.allowUnfree = true;
    };

    nix = {
        settings = {
            # Enable flakes and new 'nix' command
            experimental-features = "nix-command flakes";

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
            inherit shell;
        };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.11";
}
