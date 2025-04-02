{
    description = "Vortriz's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        stylix.url = "github:danth/stylix";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        niri = {
            url = "github:sodiboo/niri-flake";
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

        misumisumi-flakes = {
            url = "github:misumisumi/flakes";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        misumisumi-dotfiles = {
            url = "github:misumisumi/nixos-desktop-config";
        };

        alejandra = {
            url = "github:kamadorueda/alejandra";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        ...
    } @ inputs: let
        inherit (self) outputs;

        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        formatter = inputs.alejandra.defaultPackage.${system};
    in {
        # Your custom packages
        # Accessible through 'nix build', 'nix shell', etc
        packages = import ./pkgs pkgs;

        # Formatter for your nix files, available through 'nix fmt'
        # Other options beside 'alejandra' include 'nixpkgs-fmt'
        formatter.${system} = formatter;

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

        homeConfigurations.vortriz = home-manager.lib.homeManagerConfiguration {
            modules = [
            ];
        };

        devShells.${system}.default = pkgs.mkShell {
            packages =
                [
                    formatter
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
    };
}
