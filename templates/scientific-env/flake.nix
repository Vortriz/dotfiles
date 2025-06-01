{
    description = "scientific-env Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
        devshell,
        uv2nix,
        pyproject-nix,
        pyproject-build-systems,
        ...
    }: let
        inherit (nixpkgs) lib;
        pkgs = import nixpkgs {
            inherit system;
            overlays = [devshell.overlays.default];
        };

        cfg = import ./config.nix {inherit pkgs;};
        inherit (cfg) system;

        enablePython = cfg.python.enable;
        enableJulia = cfg.julia.enable;

        uv2nixCfg = import ./nix/python.nix {inherit lib cfg pkgs uv2nix pyproject-nix pyproject-build-systems;};
    in {
        formatter.${system} = pkgs.alejandra;

        packages = lib.optionalAttrs cfg.python.enable uv2nixCfg.packages;

        devShells.${system}.default = pkgs.devshell.mkShell {
            name = "scientific-dev";

            packages =
                lib.optionals enablePython ([
                    uv2nixCfg.python
                    pkgs.uv
                ]
                ++ cfg.python.extraPackages)
                ++ lib.optionals enableJulia [(import ./nix/julia.nix {inherit pkgs cfg;})]
                ++ cfg.additionalPackages;

            env = lib.attrsets.attrsToList (
                lib.optionalAttrs enablePython uv2nixCfg.env
                // lib.optionalAttrs enablePython cfg.python.env
                // lib.optionalAttrs enableJulia cfg.julia.env
                // cfg.env
            );

            devshell.startup.setup.text = lib.optionalString enablePython uv2nixCfg.shellHook;
        };
    };
}
