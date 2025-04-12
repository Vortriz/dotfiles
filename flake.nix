{
    description = "Vortriz's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
        nikpkgs.follows = "nixos-cosmic/nixpkgs";

        misumisumi-dotfiles.url = "github:misumisumi/nixos-desktop-config";
        niri.url = "github:sodiboo/niri-flake";
        stylix.url = "github:danth/stylix";

        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.darwin.follows = "";
        };
        alejandra = {
            url = "github:kamadorueda/alejandra";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        misumisumi-flakes = {
            url = "github:misumisumi/flakes";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        scientific-fhs = {
            url = "github:Vortriz/scientific-fhs";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        ulauncher = {
            url = "github:Ulauncher/Ulauncher";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        ...
    } @ inputs: let
        inherit (self) outputs;

        forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux"];
        forAllPkgs = f: forAllSystems (system: f nixpkgs.legacyPackages.${system});
    in rec {
        # Your custom packages
        # Accessible through 'nix build', 'nix shell', etc
        packages = forAllPkgs (pkgs: import ./pkgs pkgs);

        # Formatter for your nix files, available through 'nix fmt'
        # Other options beside 'alejandra' include 'nixpkgs-fmt'
        # formatter = forAllPkgs (pkgs: pkgs.alejandra); # TODO: switch to this version when https://nixpk.gs/pr-tracker.html?pr=397839
        formatter = forAllSystems (system: inputs.alejandra.defaultPackage.${system});

        # Your custom packages and modifications, exported as overlays
        overlays = import ./overlays {inherit inputs;};

        # Reusable nixos modules you might want to export
        # These are usually stuff you would upstream into nixpkgs
        nixosModules = import ./modules/nixos;

        # Reusable home-manager modules you might want to export
        # These are usually stuff you would upstream into home-manager
        homeManagerModules = import ./modules/home-manager;

        # Templates
        templates = {
            uv2nix = {
                path = ./templates/uv2nix;
                description = "uv2nix Flake";
            };

            typst-presentation = {
                path = ./templates/typst-presentation;
                description = "Typst presentation using custom Touying theme";
            };
        };

        # NixOS configuration entrypoint
        # Available through 'nixos-rebuild --flake .#your-hostname'
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs;};
                modules = [
                    # > Our main nixos configuration file <
                    ./system/configuration.nix
                ];
            };
        };

        devShells = forAllSystems (system: let
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            default = pkgs.mkShell {
                packages =
                    [
                        formatter.${system}
                        inputs.agenix.packages.${system}.default
                    ]
                    ++ (with pkgs; [
                        fd
                        git
                        jq
                        just
                        nh
                        nix
                        nix-prefetch-git
                        nvd
                        update-nix-fetchgit
                    ]);
            };
        });
    };
}
