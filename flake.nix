{
    description = "Rishi's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nbfc-linux = {
            url = "github:nbfc-linux/nbfc-linux";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix.url = "github:danth/stylix";

        # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

        # hyprland-plugins = {
        #     url = "github:hyprwm/hyprland-plugins";
        #     inputs.hyprland.follows = "hyprland";
        # };

        # hyprgrass = {
        #     url = "github:horriblename/hyprgrass";
        #     inputs.hyprland.follows = "hyprland";
        # };

        # hyprlock = {
        #     url = "github:hyprwm/hyprlock";
        #     inputs.nixpkgs.follows = "hyprland/nixpkgs";
        # };
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

        # NixOS configuration entrypoint
        # Available through 'nixos-rebuild --flake .#your-hostname'
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs;};
                modules = [
                    # > Our main nixos configuration file <
                    ./system/configuration.nix
                    inputs.stylix.nixosModules.stylix
                ];
            };
        };

        homeConfigurations.rishi = home-manager.lib.homeManagerConfiguration {
            # inherit packages;

            modules = [
            ];
        };
    };
}
