{
    unify.home = {
        lib',
        config,
        ...
    }: let
        inherit (lib') xdgAssociations;
    in {
        programs.firefox.enable = true;

        xdg.mimeApps = {
            defaultApplicationPackages = [config.programs.firefox.finalPackage];

            associations.added = let
                browser = "firefox.desktop";
            in
                (xdgAssociations browser "application" [
                    "json"
                ])
                // (xdgAssociations browser "text" [
                    "html"
                    "xhtml"
                ])
                // (xdgAssociations browser "x-scheme-handler" [
                    "mailto"
                ]);
        };

        home.sessionVariables.BROWSER = "firefox";
    };
}
