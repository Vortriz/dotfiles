{
    imports = [
        ./extensions.nix
        ./search-engines.nix
        ./settings.nix
        ./theme.nix
    ];

    programs.firefox.enable = true;
}
