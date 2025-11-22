{
    config,
    inputs,
    outputs,
    ...
}: let
    inherit (config.var) username;
    inherit (config.defaults) shell;
in {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ../secrets/agenix.nix
        ./hardware-configuration.nix
        ./hm-module.nix
        ./nixos-hw.nix
        ./plymouth.nix
        ./services.nix
        ./settings.nix
        ./variables.nix

        ./programs
        # keep-sorted end
    ];

    nixpkgs = {
        overlays = [
            outputs.overlays.modifications

            inputs.nur.overlays.default
        ];

        config.allowUnfree = true;
    };

    nix = {
        settings = {
            # Enable flakes and new 'nix' command
            experimental-features = "nix-command flakes pipe-operators";

            # Add myself to the trusted users
            trusted-users = [username];

            # Add extra Caches
            substituters = [
                "https://niri.cachix.org?priority=10"
                # "https://watersucks.cachix.org?priority=10"
                "https://vicinae.cachix.org?priority=10"
            ];
            trusted-public-keys = [
                "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
                # "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
                "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
            ];

            # Provide system architecture to nix
            system-features = ["nixos-test" "benchmark" "big-parallel" "kvm"] ++ ["gccarch-alderlake"];

            warn-dirty = false;
        };
        # Opinionated: disable channels
        channel.enable = false;

        # Opinionated: make flake registry and nix path match flake inputs (add more inputs if needed)
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
    system.stateVersion = "25.11";
}
