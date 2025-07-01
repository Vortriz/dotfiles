{
    description = "Typst presentation environment Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    outputs = {nixpkgs, ...}: let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
        devShells.x86_64-linux.default = pkgs.mkShell {
            packages = with pkgs; [
                typst
            ];
        };
    };
}
