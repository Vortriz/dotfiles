{
    description = "Vortriz's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        # keep-sorted start block=yes
        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.darwin.follows = "";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        misumisumi-flakes = {
            url = "github:misumisumi/flakes";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        niri.url = "github:sodiboo/niri-flake";
        nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
        # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
        pre-commit-hooks = {
            url = "github:cachix/git-hooks.nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        scientific-fhs.url = "github:Vortriz/scientific-fhs";
        sherlock.url = "github:Skxxtz/sherlock";
        stylix.url = "github:nix-community/stylix";
        treefmt-nix = {
            url = "github:numtide/treefmt-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # keep-sorted end
    };

    outputs = {
        self,
        nixpkgs,
        ...
    } @ inputs: let
        inherit (self) outputs;

        forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux"];
        forAllPkgs = f: forAllSystems (system: f nixpkgs.legacyPackages.${system});
        treefmtEval = forAllPkgs (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in {
        # Your custom packages, accessible through 'nix build', 'nix shell', etc
        packages = forAllPkgs (pkgs: import ./pkgs pkgs);

        # Formatter for your nix files, available through 'nix fmt'
        formatter = forAllPkgs (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

        checks = forAllSystems (system: {
            pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
                src = ./.;
                hooks = {
                    flake-checker = {
                        enable = true;
                        after = ["treefmt-nix"];
                    };
                    treefmt-nix = {
                        enable = true;
                        entry = "${treefmtEval.${system}.config.build.wrapper}/bin/treefmt";
                        pass_filenames = false;
                    };
                };
            };
        });

        # Your custom packages and modifications, exported as overlays
        overlays = import ./overlays {inherit inputs;};

        # Templates
        templates = import ./templates;

        # NixOS configuration entrypoint
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs;};
                modules = [
                    # > Our main nixos configuration file <
                    ./system/configuration.nix
                ];
            };
        };

        devShells = forAllSystems (system: let
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            default = pkgs.mkShell {
                inherit (self.checks.${system}.pre-commit-check) shellHook;

                buildInputs = [
                    self.checks.${system}.pre-commit-check.enabledPackages
                    treefmtEval.${system}.config.build.wrapper
                ];

                packages = with pkgs; [
                    # keep-sorted start prefix_order=inputs,
                    inputs.agenix.packages.${system}.default

                    fd
                    fish
                    git
                    jaq
                    just
                    micro
                    nh
                    nix
                    nix-init
                    nix-prefetch-git
                    nix-prefetch-github
                    nvd
                    nvfetcher
                    ripgrep
                    # keep-sorted end
                ];
            };
        });
    };
}
