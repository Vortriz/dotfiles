{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        systems.url = "github:nix-systems/x86_64-linux";
    };

    outputs = {
        nixpkgs,
        systems,
        ...
    }: let
        inherit (nixpkgs) lib;
        pkgsFor = lib.genAttrs systems (system: import nixpkgs {inherit system;});
        forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    in {
        formatter = forEachSystem (pkgs:
            pkgs.treefmt.withConfig {
                runtimeInputs = [pkgs.nixfmt];
                settings.formatter.nixfmt = {
                    command = "nixfmt";
                    includes = ["*.nix"];
                    options = ["--indent=4"];
                };
            });

        devShells.default = forEachSystem (pkgs:
            pkgs.mkShell {
                packages = [];
            });
    };
}
