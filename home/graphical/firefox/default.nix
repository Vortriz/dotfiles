{config, ...}: {
    imports = [
        ./search-engines.nix
        ./settings.nix
        ./theme.nix
    ];

    programs.firefox.enable = true;

    xdg.mimeApps.defaultApplications = config.custom-lib.xdgAssociations "application" "browser" [
        # keep-sorted start
        "json"
        "x-extension-htm"
        "x-extension-html"
        "x-extension-shtml"
        "x-extension-xht"
        "x-extension-xhtml"
        # keep-sorted end
    ];
}
