{
    description = "Julia Template";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = {
        nixpkgs,
        flake-utils,
        ...
    }:
        flake-utils.lib.eachDefaultSystem (
            system: let
                pkgs = nixpkgs.legacyPackages.${system};

                nativeBuildInputs = with pkgs; [
                    (julia.withPackages.override {
                        precompile = false;
                    }[ # Add packages here
                        "LanguageServer"
                    ])
                ];

                buildInputs = with pkgs; [];
            in {
                devShells.default = pkgs.mkShell {
                    inherit nativeBuildInputs buildInputs;

                    shellHook = ''
                        export JULIA_NUM_THREADS=$(nproc)

                        echo "Precompiling..."
                        julia -e "using Pkg; Pkg.precompile()"
                    '';
                };
            }
        );
}