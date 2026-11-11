{
    description = "Vortriz's NixOS configuration";

    outputs =
        { self, ... }@args:
        let
            inputs = (import ./.tack) { overrides = args.tackOverrides or { }; };
            self' = self // {
                inherit inputs;
            };

            inherit (inputs.nixpkgs.lib.fileset) toList fileFilter;
            inherit (inputs.nixpkgs.lib.strings) hasPrefix;

            import-tree =
                path: fileFilter (file: file.hasExt "nix" && !(hasPrefix "_" file.name)) path |> toList;
            import-mutiple-trees = paths: (map import-tree paths) |> builtins.concatLists;
        in
        inputs.flake-parts.lib.mkFlake
            {
                inherit inputs;
                self = self';
            }
            {
                systems = import inputs.systems;

                imports = [
                    inputs.unify.flakeModule
                ]
                ++ (import-mutiple-trees [
                    ./hosts
                    ./modules
                ]);

                flake.templates = import ./templates;
            };

    nixConfig = {
        extra-substituters = [
            "https://niri-nix.cachix.org"
            "https://cache.manic.systems"
        ];
        extra-trusted-public-keys = [
            "niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0="
            "cache.manic.systems-1:s6OZanN8Us8vRi0jVivP3qlMn0cYHBjBALKrNe5nH8s="
        ];
    };
}
