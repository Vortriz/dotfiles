{
    description = "Vortriz's NixOS configuration";

    outputs = {
        flake-parts,
        import-tree,
        ...
    } @ inputs:
        flake-parts.lib.mkFlake {inherit inputs;} {
            systems = import inputs.systems;

            imports = [
                inputs.unify.flakeModule
                (import-tree [
                    ./hosts
                    ./modules
                ])
            ];

            flake.templates = import ./templates;
        };

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        systems.url = "github:nix-systems/x86_64-linux";
        flake-parts.url = "github:hercules-ci/flake-parts";
        import-tree.url = "github:vic/import-tree";
        unify = {
            url = "git+https://codeberg.org/quasigod/unify";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.flake-parts.follows = "flake-parts";
            inputs.home-manager.follows = "home-manager";
        };

        # keep-sorted start block=yes
        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
            inputs.darwin.follows = "";
            inputs.systems.follows = "systems";
        };
        git-hooks = {
            url = "github:cachix/git-hooks.nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        niri = {
            url = "github:sodiboo/niri-flake";
            # inputs.niri-unstable.url = "github:YaLTeR/niri?ref=pull/1704/head";
        };
        niri-shell = {
            url = "/mnt/HOUSE/dev/others/niri-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware.url = "github:NixOS/nixos-hardware";
        nur = {
            url = "github:nix-community/NUR";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.flake-parts.follows = "flake-parts";
        };
        quickshell = {
            url = "git+https://git.outfoxxed.me/quickshell/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.systems.follows = "systems";
            inputs.flake-parts.follows = "flake-parts";
        };
        treefmt-nix = {
            url = "github:numtide/treefmt-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        vicinae.url = "github:vicinaehq/vicinae";
        # keep-sorted end

        # only for testing purposes
        # nur-vortriz = {
        #     url = "path:/mnt/HOUSE/dev/others/nur-packages";
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };
    };

    # Enable at the time of fresh deployment
    # nixConfig = {
    #     extra-substituters = [
    #         "https://niri.cachix.org"
    #         "https://vicinae.cachix.org"
    #     ];
    #     extra-trusted-public-keys = [
    #         "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    #         "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    #     ];
    # };
}
