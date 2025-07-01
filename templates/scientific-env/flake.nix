{
    description = "scientific-env Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

        flake-utils.url = "github:numtide/flake-utils";

        devshell = {
            url = "github:numtide/devshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # For using python via uv2nix
        pyproject-nix = {
            url = "github:pyproject-nix/pyproject.nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        uv2nix = {
            url = "github:pyproject-nix/uv2nix";
            inputs.pyproject-nix.follows = "pyproject-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        pyproject-build-systems = {
            url = "github:pyproject-nix/build-system-pkgs";
            inputs.pyproject-nix.follows = "pyproject-nix";
            inputs.uv2nix.follows = "uv2nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        nixpkgs,
        flake-utils,
        devshell,
        ...
    }: let
        systems = ["x86_64-linux"];
    in
        flake-utils.lib.eachSystem systems (
            system: let
                pkgs = import nixpkgs {
                    inherit system;
                    overlays = [devshell.overlays.default];
                };

                inherit (nixpkgs) lib;

                # Python package used by uv
                python = pkgs.python312;
            in {
                formatter = pkgs.alejandra;

                devShells.default = pkgs.devshell.mkShell {
                    name = "scientific-dev";

                    packages =
                        (with pkgs; [
                            # Python stuff
                            python
                            uv
                            nodejs # for using copilot in marimo
                            ruff # for formatting

                            # Julia stuff
                            julia-bin
                            xwayland-satellite

                            # Extra stuff
                            typst
                        ])
                        ++ (with pkgs.python312Packages; [
                            python-lsp-server # for LSP features in marimo
                        ]);

                    env = lib.attrsets.attrsToList (
                        {
                            # Prevent uv from managing Python downloads
                            UV_PYTHON_DOWNLOADS = "never";
                            # Force uv to use nixpkgs Python interpreter
                            UV_PYTHON = python.interpreter;
                        }
                        // lib.optionalAttrs pkgs.stdenv.isLinux {
                            # Python libraries often load native shared objects using dlopen(3).
                            # Setting LD_LIBRARY_PATH makes the dynamic library loader aware of libraries without using RPATH for lookup.
                            LD_LIBRARY_PATH = lib.makeLibraryPath pkgs.pythonManylinuxPackages.manylinux1;
                        }
                        // {
                            JULIA_NUM_THREADS = 16;
                            DISPLAY = ":0";
                        }
                    );

                    devshell = {
                        startup.default.text = ''
                            unset PYTHONPATH
                        '';

                        motd = "";
                    };
                };
            }
        );
}
