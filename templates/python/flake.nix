{
    description = "Minimal scientific env";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        systems.url = "github:nix-systems/x86_64-linux";
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
            inherit (nixpkgs) lib;

            pkgs = import nixpkgs {
                inherit system;
                overlays = [devshell.overlays.default];
            };
        in {
            formatter = pkgs.alejandra;

            # Impurely using uv to manage virtual environments
            devShell = let
                python-pkg = pkgs.python312;
            in
                pkgs.devshell.mkShell
                {
                    name = "python";
                    devshell.motd = "";

                    packages =
                        [python-pkg]
                        ++ (with pkgs; [
                            uv
                            nodejs_latest
                            ruff
                        ]);

                    env = [
                        {
                            # Prevent uv from managing Python downloads
                            name = "UV_PYTHON_DOWNLOADS";
                            value = "never";
                        }
                        {
                            # Force uv to use nixpkgs Python interpreter
                            name = "UV_PYTHON";
                            value = python-pkg.interpreter;
                        }
                        {
                            # Python libraries often load native shared objects using dlopen(3).
                            # Setting LD_LIBRARY_PATH makes the dynamic library loader aware of libraries without using RPATH for lookup.
                            # We use manylinux2014 which is compatible with 3.7.8+, 3.8.4+, 3.9.0+
                            name = "LD_LIBRARY_PATH";
                            prefix = lib.makeLibraryPath pkgs.pythonManylinuxPackages.manylinux2014;
                        }
                    ];

                    devshell.startup.default.text = "unset PYTHONPATH";
                };
        });
}
