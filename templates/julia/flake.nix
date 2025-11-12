{
    description = "Minimal scientific env";

    inputs = {
        # set your systems using: https://github.com/nix-systems/nix-systems?tab=readme-ov-file#available-system-flakes
        systems.url = "github:nix-systems/x86_64-linux";

        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        flake-utils = {
            url = "github:numtide/flake-utils";
            inputs.systems.follows = "systems";
        };
        devshell = {
            url = "github:numtide/devshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        nixpkgs,
        flake-utils,
        devshell,
        ...
    }:
        flake-utils.lib.eachDefaultSystem (system: let
            pkgs = import nixpkgs {
                inherit system;
                overlays = [devshell.overlays.default];
            };
        in {
            formatter = pkgs.alejandra;

            # Impurely using uv to manage virtual environments
            devShell = let
                julia-pkg = pkgs.julia.withPackages ["LanguageServer"];
            in
                pkgs.devshell.mkShell
                {
                    name = "julia";
                    devshell.motd = "";

                    packages = [julia-pkg];

                    env = [
                        {
                            name = "JULIA_NUM_THREADS";
                            value = "auto";
                        }
                        {
                            name = "julia";
                            value = "${julia-pkg}/bin/julia";
                        }
                    ];
                };
        });
}
