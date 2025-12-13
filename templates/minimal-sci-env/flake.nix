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
        self,
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

            python-pkg = pkgs.python312;

            # Pluto manages environment for each notebook independently,
            # so there is no need to include other Julia packages here.
            juliaEnv = pkgs.julia-bin.withPackages.override
            {
                augmentedRegistry = (pkgs.callPackage ./_sources/generated.nix {}).registry.src;
            }
            [
                "Pluto"
                "LanguageServer"
                "JuliaFormatter"
            ];
        in {
            formatter = pkgs.treefmt.withConfig {
                runtimeInputs = [
                    pkgs.nixfmt
                    juliaEnv
                ];
                settings = {
                    excludes = ["_sources/**"];
                    formatter.nixfmt = {
                        command = "nixfmt";
                        includes = ["*.nix"];
                        options = ["--indent=4"];
                    };
                };
            };

            # Impurely using uv to manage virtual environments
            devShells = {
                default = self.devShells.${system}.python;

                python = pkgs.devshell.mkShell {
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

                julia = pkgs.devshell.mkShell {
                    name = "julia";
                    devshell.motd = "";

                    commands = [
                        {
                            name = "pluto";
                            category = "[julia]";
                            help = "Launch Pluto";
                            command = ''
                                ${juliaEnv}/bin/julia -e "import Pluto; Pluto.run()"
                            '';
                        }
                        {
                            name = "jlfmt";
                            category = "[julia]";
                            help = "Format Julia files using JuliaFormatter";
                            command = ''
                                ${juliaEnv}/bin/julia ${./fmt.jl}
                            '';
                        }
                    ];

                    env = [
                        {
                            name = "JULIA_NUM_THREADS";
                            value = "auto";
                        }
                        {
                            name = "julia";
                            value = "${juliaEnv}/bin/julia";
                        }
                    ];

                    packages = [
                        # for updating julia registry
                        pkgs.nvfetcher

                        juliaEnv
                    ];
                };

                typst = pkgs.devshell.mkShell {
                    name = "typst";
                    devshell.motd = "";

                    packages = [pkgs.typst];
                };
            };
        });
}
