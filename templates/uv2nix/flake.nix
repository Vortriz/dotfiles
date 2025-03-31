{
    description = "uv2nix Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
        self,
        nixpkgs,
        uv2nix,
        pyproject-nix,
        pyproject-build-systems,
        ...
    }: let
        inherit (nixpkgs) lib;

        # Load a uv workspace from a workspace root.
        # Uv2nix treats all uv projects as workspace projects.
        workspace = uv2nix.lib.workspace.loadWorkspace {workspaceRoot = ./.;};

        # Create package overlay from workspace.
        overlay = workspace.mkPyprojectOverlay {
            # Prefer prebuilt binary wheels as a package source.
            # Sdists are less likely to "just work" because of the metadata missing from uv.lock.
            # Binary wheels are more likely to, but may still require overrides for library dependencies.
            sourcePreference = "wheel"; # or sourcePreference = "sdist";
            # Optionally customise PEP 508 environment
            # environ = {
            #     platform_release = "5.10.65";
            # };
        };

        # Extend generated overlay with build fixups
        #
        # Uv2nix can only work with what it has, and uv.lock is missing essential metadata to perform some builds.
        # This is an additional overlay implementing build fixups.
        # See:
        # - https://pyproject-nix.github.io/uv2nix/FAQ.html
        pyprojectOverrides = _final: _prev: {
            # Implement build fixups here.
            # Note that uv2nix is _not_ using Nixpkgs buildPythonPackage.
            # It's using https://pyproject-nix.github.io/pyproject.nix/build.html
        };

        # This example is only using x86_64-linux
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        # Use Python 3.12 from nixpkgs
        python = pkgs.python312;

        # Construct package set
        pythonSet =
            # Use base package set from pyproject.nix builders
            (pkgs.callPackage pyproject-nix.build.packages {
                inherit python;
            })
            .overrideScope
            (
                lib.composeManyExtensions [
                    pyproject-build-systems.overlays.default
                    overlay
                    pyprojectOverrides
                ]
            );
    in {
        # Package a virtual environment as our main application.
        #
        # Enable no optional dependencies for production build.
        packages.x86_64-linux.default = pythonSet.mkVirtualEnv builtins.toString ./. workspace.deps.default;

        # Make hello runnable with `nix run`
        # apps.x86_64-linux = {
        #     default = {
        #         type = "app";
        #         program = "${self.packages.x86_64-linux.default}/bin/hello";
        #     };
        # };

        # Impurely using uv to manage virtual environments
        devShells.x86_64-linux = let
            mkScript = name: text: let
                script = pkgs.writers.writeFishBin name text;
            in
                script;

            scripts = [
                (mkScript "activate" ''source .venv/bin/activate.fish'')
            ];
        in {
            # It is of course perfectly OK to keep using an impure virtualenv workflow and only use uv2nix to build packages.
            # This devShell simply adds Python and undoes the dependency leakage done by Nixpkgs Python infrastructure.
            default = pkgs.mkShell {
                packages =
                    [
                        python
                    ]
                    ++ (with pkgs; [
                        uv
                    ])
                    ++ scripts;
                env =
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
                    };
                shellHook = ''
                  unset PYTHONPATH
                  uv venv
                '';
            };
        };
    };
}
