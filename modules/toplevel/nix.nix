{inputs, ...}: {
    unify = {
        nixos = {hostConfig, ...}: {
            nixpkgs = {
                config.allowUnfree = true;
                overlays = [
                    inputs.nur-vortriz.overlays.default
                ];
            };

            nix = {
                gc.automatic = false; # because nh
                optimise.automatic = true;

                settings = {
                    # Enable flakes and new 'nix' command
                    experimental-features = "nix-command flakes pipe-operators";

                    # Add myself to the trusted users
                    trusted-users = [hostConfig.username];

                    # Provide system architecture to nix
                    system-features = ["nixos-test" "benchmark" "big-parallel" "kvm"];

                    warn-dirty = false;
                };
                channel.enable = false;

                registry.nixpkgs.flake = inputs.nixpkgs;

                # To make sure that old nix commands use the same nixpkgs as the flake
                nixPath = ["nixpkgs=flake:nixpkgs"];

                # Opinionated: make flake registry and nix path match flake inputs (add more inputs if needed)
                # registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
                # nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
            };
        };

        home = {
            # nh
            programs.nh = {
                enable = true;

                clean = {
                    enable = true;

                    extraArgs = "--keep 4 --optimise --no-gcroots";
                };
            };

            # nix-index
            imports = [inputs.nix-index-database.homeModules.nix-index];

            programs.nix-index.enable = true;
            programs.nix-index-database.comma.enable = true;

            # direnv
            programs.direnv = {
                enable = true;
                nix-direnv.enable = true;

                silent = true;
            };

            # nix-your-shell
            programs.nix-your-shell = {
                enable = true;
                nix-output-monitor.enable = true;
            };
        };
    };
}
