{inputs, ...}: {
    imports = [
        inputs.treefmt-nix.flakeModule
    ];

    perSystem = {
        treefmt.config = {
            # Used to find the project root
            # inherit (config.flake-root) projectRootFile;
            projectRootFile = "LICENSE";

            programs = {
                alejandra.enable = true;
                deadnix.enable = true;
                statix.enable = true;
                prettier.enable = true;
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

                    prettier.options = ["--tab-width" "4"];
                };
            };
        };
    };
}
