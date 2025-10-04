{
    config,
    lib,
    osConfig,
    pkgs,
    ...
}: {
    options = {
        niri-lib = lib.mkOption {
            default = {};

            type = lib.types.attrs;

            description = ''
                This option allows modules to define helper functions, constants, etc.
            '';
        };
    };

    config = let
        inherit (config.lib.niri.actions) spawn-sh;
        inherit (osConfig.defaults) terminal;
    in {
        niri-lib = {
            open = {
                app,
                args ? "",
                title ? "Launch ${lib.getName app}",
            }: {
                action = spawn-sh (lib.strings.trim "${lib.getExe app} ${args}");
                hotkey-overlay = {inherit title;};
            };

            open-tui = {
                app,
                app-id,
            }: {
                action = spawn-sh "${lib.getExe terminal} -o confirm_os_window_close=0 --app-id=${app-id} ${app}";
                hotkey-overlay.title = "Launch ${app-id}";
            };

            run = {
                cmd,
                notif ? null,
                title ? null,
            }: {
                action.spawn-sh =
                    if notif == null
                    then cmd
                    else ''${cmd} && ${lib.getExe pkgs.libnotify} "${notif}"'';
                hotkey-overlay =
                    if title == null
                    then {hidden = true;}
                    else {inherit title;};
            };
        };
    };
}
