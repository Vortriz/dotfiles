{
    lib,
    osConfig,
    ...
}: let
    inherit (osConfig.defaults) terminal;
in {
    programs.sherlock.settings.config = {
        appearance = {
            width = 600;
            height = 400;
            icon_paths = ["~/.config/sherlock/icons/"];
            icon_size = 22;
            search_icon = false;
            status_bar = false;
        };

        behavior = {
            caching = true;
        };

        default_apps = {
            terminal = lib.getName terminal;
        };
    };
}
