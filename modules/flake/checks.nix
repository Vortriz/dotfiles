{inputs, ...}: {
    imports = [
        inputs.git-hooks.flakeModule
    ];

    perSystem = {self', ...}: {
        pre-commit.settings.hooks = {
            flake-checker = {
                enable = true;
                after = ["treefmt-nix"];
            };
            treefmt = {
                enable = true;
                package = self'.formatter;
            };
        };
    };
}
