{
    description = "Vortriz's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        niri.url = "github:sodiboo/niri-flake";

        stylix.url = "github:danth/stylix";

        scientific-fhs.url = "github:manuelbb-upb/scientific-fhs";

        ulauncher = {
            url = "github:Ulauncher/Ulauncher";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        yazi.url = "github:sxyazi/yazi";

        vortriz-flakes = {
            url = "github:Vortriz/flakes/feat/zotero-addons";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        misumisumi-dotfiles = {
            url = "github:misumisumi/nixos-desktop-config";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        ...
    } @ inputs: let
        inherit (self) outputs;
        # Supported systems for your flake packages, shell, etc.
        systems = [
            "x86_64-linux"
        ];
        # This is a function that generates an attribute by calling a function you
        # pass to it, with each system as an argument
        forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
        # Your custom packages
        # Accessible through 'nix build', 'nix shell', etc
        packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
        # Formatter for your nix files, available through 'nix fmt'
        # Other options beside 'alejandra' include 'nixpkgs-fmt'
        formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

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
    };
}
