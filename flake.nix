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
        anifetch = {
            url = "github:Notenlish/anifetch";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        mcp-nixos.url = "github:utensils/mcp-nixos";
        misumisumi-flakes = {
            url = "github:misumisumi/flakes";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        niri.url = "github:sodiboo/niri-flake";
        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-search-tv = {
            url = "github:3timeslazy/nix-search-tv";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
        nur = {
            url = "github:nix-community/NUR";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nur-vortriz = {
            url = "path:/mnt/HOUSE/dev/nix/nur-packages";
            inputs.nixpkgs.follows = "nixpkgs";
        };
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
        zed-extensions.url = "github:DuskSystems/nix-zed-extensions";
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
        overlays = import ./overlays {};

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

                packages =
                    (with pkgs; [
                        # keep-sorted start
                        fd
                        fish
                        git
                        jaq
                        just
                        micro
                        nh
                        nix
                        nix-init
                        nix-melt
                        nix-prefetch-git
                        nix-prefetch-github
                        nvd
                        nvfetcher
                        ripgrep
                        # keep-sorted end
                    ])
                    ++ (with inputs; [
                        # keep-sorted start
                        agenix.packages.${system}.default
                        # keep-sorted end
                    ]);
            };
        });
    };
}
