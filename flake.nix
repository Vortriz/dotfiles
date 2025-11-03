{
    description = "Vortriz's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        systems.url = "github:nix-systems/x86_64-linux";
        flake-utils = {
            url = "github:numtide/flake-utils";
            inputs.systems.follows = "systems";
        };

        # keep-sorted start block=yes
        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.darwin.follows = "";
            inputs.systems.follows = "systems";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        niri = {
            url = "github:sodiboo/niri-flake";
            # inputs.niri-unstable.url = "github:YaLTeR/niri?ref=pull/1704/head";
        };
        niri-shell = {
            url = "/mnt/HOUSE/dev/niri-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware.url = "github:NixOS/nixos-hardware";
        nur = {
            url = "github:nix-community/NUR";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        pre-commit-hooks = {
            url = "github:cachix/git-hooks.nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        quickshell = {
            url = "git+https://git.outfoxxed.me/quickshell/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.systems.follows = "systems";
        };
        treefmt-nix = {
            url = "github:numtide/treefmt-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        vicinae.url = "github:vicinaehq/vicinae";
        # keep-sorted end
    };

    outputs = {
        self,
        nixpkgs,
        flake-utils,
        treefmt-nix,
        ...
    } @ inputs:
        flake-utils.lib.eachDefaultSystem (system: let
            pkgs = nixpkgs.legacyPackages.${system};

            treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        in {
            # Formatter for your nix files, available through 'nix fmt'
            formatter = treefmtEval.config.build.wrapper;

            checks = {
                pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
                    src = ./.;
                    hooks = {
                        flake-checker = {
                            enable = true;
                            after = ["treefmt-nix"];
                        };
                        treefmt = {
                            enable = true;
                            package = self.formatter.${system};
                        };
                    };
                };
            };

            devShells = {
                default = pkgs.mkShell {
                    inherit (self.checks.${system}.pre-commit-check) shellHook;

                    buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;

                    env = {
                        NIXOS_CONFIG = self.nixosConfigurations.nixos.config.var.dotfilesDir;
                    };

                    packages =
                        (with pkgs; [
                            # keep-sorted start
                            fd
                            fish
                            git
                            jaq
                            just
                            micro
                            nh
                            nix-init
                            nix-melt
                            nix-prefetch-git
                            nix-prefetch-github
                            nom
                            nvd
                            nvfetcher
                            ripgrep
                            # keep-sorted end
                        ])
                        ++ (with inputs; [
                            # keep-sorted start
                            agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
                            # keep-sorted end
                        ])
                        ++ (with self.nixosConfigurations.nixos.config; [
                            nix.package
                        ]);
                };
            };
        })
        // {
            # Your custom packages and modifications, exported as overlays
            overlays = import ./overlays {};

            # Templates
            templates = import ./templates;

            # NixOS configuration entrypoint
            nixosConfigurations = {
                nixos = nixpkgs.lib.nixosSystem {
                    specialArgs = {
                        inherit inputs;
                        inherit (self) outputs;
                        system = "x86_64-linux";
                    };
                    modules = [
                        # > Our main nixos configuration file <
                        ./system/configuration.nix
                    ];
                };

                iso = nixpkgs.lib.nixosSystem {
                    specialArgs = {
                        inherit inputs;
                        inherit (self) outputs;
                        system = "x86_64-linux";
                    };
                    modules = [./iso.nix];
                };
            };
        };

    # Enable at the time of fresh deployment
    # nixConfig = {
    #     extra-substituters = [
    #         "https://niri.cachix.org"
    #         "https://vicinae.cachix.org"
    #     ];
    #     extra-trusted-public-keys = [
    #         "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    #         "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    #     ];
    # };
}
