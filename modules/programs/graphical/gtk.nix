{
    unify.home = {pkgs, ...}: {
        gtk = {
            enable = true;

            iconTheme = {
                package = pkgs.adwaita-icon-theme;
                name = "Adwaita";
            };
        };
    };
}
