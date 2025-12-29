{inputs, ...}: {
    imports = [
        inputs.treefmt-nix.flakeModule
    ];

    perSystem = {
        treefmt.config = {
            # Used to find the project root
            projectRootFile = "LICENSE";

            programs = {
                alejandra.enable = true;
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
                    alejandra = {
                        options = ["--threads" "16"];
                        priority = 3;
                    };

                    deadnix.priority = 1;

                    statix.priority = 2;
                };
            };
        };
    };
}
