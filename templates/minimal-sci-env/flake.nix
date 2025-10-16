{
    description = "Minimal scientific env";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

        devshell = {
            url = "github:numtide/devshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        nixpkgs,
        devshell,
        ...
    }: let
        inherit (nixpkgs) lib;

        # Change accordingly
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            overlays = [devshell.overlays.default];
        };

        cfg = import ./config.nix;
    in {
        formatter.${system} = pkgs.alejandra;

        # Impurely using uv to manage virtual environments
        devShells.${system}.default = let
            # Use Python 3.12 from nixpkgs
            python = pkgs.python312;
        in
            pkgs.devshell.mkShell
            {
                name = "sci";
                devshell.motd = "";

                packages =
                    lib.lists.optionals cfg.enablePython (
                        [python]
                        ++ (with pkgs; [
                            uv
                            nodejs_latest
                            ruff
                        ])
                        ++ (with pkgs.python312Packages; [
                            python-lsp-server
                        ])
                    )
                    ++ lib.lists.optionals cfg.enableJulia [
                        pkgs.julia-bin
                    ]
                    ++ lib.lists.optionals cfg.enableTypst [
                        pkgs.typst
                    ];

                env =
                    lib.lists.optionals cfg.enablePython [
                        {
                            # Prevent uv from managing Python downloads
                            name = "UV_PYTHON_DOWNLOADS";
                            value = "never";
                        }
                        {
                            # Force uv to use nixpkgs Python interpreter
                            name = "UV_PYTHON";
                            value = python.interpreter;
                        }
                        {
                            # Python libraries often load native shared objects using dlopen(3).
                            # Setting LD_LIBRARY_PATH makes the dynamic library loader aware of libraries without using RPATH for lookup.
                            # We use manylinux2014 which is compatible with 3.7.8+, 3.8.4+, 3.9.0+
                            name = "LD_LIBRARY_PATH";
                            prefix = lib.makeLibraryPath pkgs.pythonManylinuxPackages.manylinux2014;
                        }
                    ]
                    ++ lib.lists.optionals cfg.enableJulia [
                        {
                            name = "JULIA_NUM_THREADS";
                            value = "auto";
                        }
                    ];

                commands = lib.lists.optionals cfg.enablePython [
                    {
                        help = "Activate the Python virtual environment";
                        name = "activate";
                        command = "source .venv/bin/activate.fish";
                    }
                ];

                devshell.startup.default.text = lib.strings.optionalString cfg.enablePython "unset PYTHONPATH";
            };
    };
}
