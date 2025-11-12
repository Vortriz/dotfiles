{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        systems.url = "github:nix-systems/x86_64-linux";
        flake-utils = {
            url = "github:numtide/flake-utils";
            inputs.systems.follows = "systems";
        };
    };

    outputs = {
        nixpkgs,
        flake-utils,
        ...
    }:
        flake-utils.lib.eachDefaultSystem (
            system: let
                pkgs = nixpkgs.legacyPackages.${system};
            in {
                formatter = pkgs.treefmt.withConfig {
                    runtimeInputs = [pkgs.nixfmt];
                    settings.formatter.nixfmt = {
                        command = "nixfmt";
                        includes = ["*.nix"];
                        options = ["--indent=4"];
                    };
                };

                devShells.default = pkgs.mkShell {
                    packages = [];
                };
            }
        );
}
