{
    unify.home =
        {
            lib,
            config,
            ...
        }:
        {
            programs.firefox.enable = true;

            xdg.mimeApps = {
                defaultApplicationPackages = [ config.programs.firefox.finalPackage ];

                associations.added =
                    let
                        browser = "firefox.desktop";
                    in
                    lib.attrsets.genAttrs [
                        "application/json"
                        "text/html"
                        "text/xhtml"
                        "x-scheme-handler/mailto"
                    ] (_: browser);
            };

            home.sessionVariables.BROWSER = "firefox";
        };
}
