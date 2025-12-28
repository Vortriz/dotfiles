{
    description = "Scientific dev environment with Julia";

    inputs = {
        # set your systems using: https://github.com/nix-systems/nix-systems?tab=readme-ov-file#available-system-flakes
        systems.url = "github:nix-systems/x86_64-linux";

        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        flake-parts.url = "github:hercules-ci/flake-parts";
        treefmt-nix = {
            url = "github:numtide/treefmt-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        devshell = {
            url = "github:numtide/devshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nima = {
            url = "github:Vortriz/nix-manipulator";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.systems.follows = "systems";
            inputs.devshell.follows = "devshell";
        };
    };

    outputs = {flake-parts, ...} @ inputs:
        flake-parts.lib.mkFlake {inherit inputs;} {
            systems = import inputs.systems;

            imports = [
                inputs.devshell.flakeModule
                inputs.treefmt-nix.flakeModule
            ];

            perSystem = {
                lib,
                pkgs,
                system,
                ...
            }: let
                juliaEnv = pkgs.julia.withPackages.override
                {
                    augmentedRegistry = pkgs.callPackage ./nix/registry.nix {};
                }
                [
                    "ArgParse"
                    "Pluto"
                    "LanguageServer"
                    "JuliaFormatter"
                ];

                julia = lib.getExe juliaEnv;
            in {
                treefmt = {
                    programs = {
                        deadnix.enable = true;
                        statix.enable = true;
                        nixfmt = {
                            enable = true;
                            indent = 4;
                        };
                    };

                    settings.formatter = {
                        jlfmt = {
                            priority = 1;
                            command = julia;
                            options = ["${./nix/fmt.jl}"];
                            includes = ["*.jl"];
                        };
                    };
                };

                packages = {
                    default = juliaEnv;
                };

                devshells.default = {
                    devshell = {
                        motd = "";
                        name = "pluto-julia";
                    };

                    commands = [
                        {
                            name = "create";
                            category = "[julia]";
                            help = "Create Pluto notebook and run it";
                            command = lib.getExe (
                                pkgs.writeScriptBin "create" ''
                                    if [ -z "$1" ]; then
                                        ${julia} ${./nix/create.jl} --help
                                    else
                                        ${julia} ${./nix/create.jl} "$1"
                                    fi
                                ''
                            );
                        }
                        {
                            name = "pluto";
                            category = "[julia]";
                            help = "Launch Pluto";
                            command = ''
                                ${julia} -e "import Pluto; Pluto.run()"
                            '';
                        }
                        {
                            name = "update-registry";
                            category = "[julia]";
                            help = "Update the Julia package registry used in this environment";
                            command = lib.getExe (
                                pkgs.writers.writePython3Bin "update-registry" {
                                    libraries = [inputs.nima.packages.${system}.default];
                                }
                                ./nix/update.py
                            );
                        }
                    ];

                    env = [
                        {
                            name = "JULIA_NUM_THREADS";
                            value = "auto";
                        }
                        {
                            name = "julia";
                            value = julia;
                        }
                    ];

                    packages = [
                        juliaEnv
                        pkgs.nix-prefetch-git
                    ];

                    devshell.startup.default.text = let
                        projectPath = "${juliaEnv.projectAndDepot.outPath}/project";
                    in ''
                        rm -f Project.toml
                        ln -sf ${projectPath}/Project.toml $PRJ_ROOT/
                        rm -f Manifest.toml
                        ln -sf ${projectPath}/Manifest.toml $PRJ_ROOT/
                    '';
                };
            };
        };
}
