{
    imports = [
        ./theme.nix
    ];

    programs.firefox = {
        enable = true;

        profiles.default = {
            settings = import ./settings.nix;
            search = import ./search-engines.nix;
        };

        policies =
            {
                ExtensionSettings = import ./extensions.nix;
            }
            // import ./policies.nix;
    };
}
