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
        niri-shell = {
            url = "github:Vortriz/niri-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # mcp-nixos.url = "github:utensils/mcp-nixos"; # wait for zed to support this
        niri.url = "github:sodiboo/niri-flake";
        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware.url = "github:NixOS/nixos-hardware";
        # nixos-cli.url = "github:nix-community/nixos-cli";
        # nur = {
        #     url = "github:nix-community/NUR";
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };
        # nur-vortriz = {
        #     url = "path:/mnt/HOUSE/dev/nix/nur-packages";
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };
        pre-commit-hooks = {
            url = "github:cachix/git-hooks.nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        sherlock = {
            url = "github:Skxxtz/sherlock";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
        };
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
        treefmt-nix,
        ...
    } @ inputs: let
        inherit (self) outputs;
        inherit (nixpkgs) lib legacyPackages;

        forAllSystems = lib.genAttrs ["x86_64-linux"];
        forAllPkgs = f: forAllSystems (system: f legacyPackages.${system});
        treefmtEval = forAllPkgs (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
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
                    treefmt = {
                        enable = true;
                        package = outputs.formatter.${system};
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
            nixos = lib.nixosSystem {
                specialArgs = {
                    inherit inputs outputs;
                    system = "x86_64-linux";
                };
                modules = [
                    # > Our main nixos configuration file <
                    ./system/configuration.nix
                ];
            };
        };

        devShells = forAllPkgs (pkgs: {
            default = pkgs.mkShell {
                inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;

                buildInputs = self.checks.${pkgs.system}.pre-commit-check.enabledPackages;

                env = {
                    NIXOS_CONFIG = self.nixosConfigurations.nixos.config.var.dotfilesDir;
                };

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
                        nix-init
                        nix-melt
                        nix-prefetch-git
                        nix-prefetch-github
                        nom
                        nvd
                        nvfetcher
                        ripgrep
                        # keep-sorted end
                    ])
                    ++ (with inputs; [
                        # keep-sorted start
                        agenix.packages.${pkgs.system}.default
                        # keep-sorted end
                    ])
                    ++ (with self.nixosConfigurations.nixos.config; [
                        nix.package
                    ]);
            };
        });
    };

    # Enable at the time of fresh deployment
    # nixConfig = {
    #     extra-substituters = [
    #         "https://niri.cachix.org"
    #         "https://watersucks.cachix.org"
    #     ];
    #     extra-trusted-public-keys = [
    #         "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    #         "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
    #     ];
    # };
}
