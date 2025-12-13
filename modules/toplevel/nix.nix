{inputs, ...}: {
    unify = {
        nixos = {hostConfig, ...}: {
            nixpkgs = {
                config.allowUnfree = true;
                overlays = [
                    inputs.nur.overlays.default
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

                    # Add extra Caches
                    substituters = [
                        "https://niri.cachix.org?priority=10"
                        "https://vicinae.cachix.org?priority=10"
                    ];
                    trusted-public-keys = [
                        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
                        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
                    ];

                    # Provide system architecture to nix
                    system-features = ["nixos-test" "benchmark" "big-parallel" "kvm"] ++ ["gccarch-alderlake"];

                    warn-dirty = false;
                };
                channel.enable = false;

                registry.nixpkgs.flake = inputs.nixpkgs;

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
