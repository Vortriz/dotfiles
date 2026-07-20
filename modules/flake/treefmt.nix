{ inputs, ... }: {
    imports = [
        inputs.treefmt-nix.flakeModule
    ];

    perSystem = {
        treefmt.config = {
            # Used to find the project root
            projectRootFile = "LICENSE";

            programs = {
                nixfmt = {
                    enable = true;
                    indent = 4;
                };
                deadnix.enable = true;
                statix.enable = true;
                biome = {
                    enable = true;
                    settings = {
                        formatter = {
                            indentStyle = "space";
                            indentWidth = 4;
                            lineWidth = 100;
                        };
                    };
                };
                keep-sorted.enable = true;
            };

            settings = {
                formatter = {
                    # nix
                    deadnix.priority = 1;
                    statix.priority = 2;
                    nixfmt.priority = 3;
                };
            };
        };
    };
}
