{
    pkgs,
    ...
}: {
    programs.niri = {
        # settings.binds = {
        #     "Mod+Space".action.spawn = "fuzzel";
        # };
        config = builtins.readFile ./configs/config.kdl;
    };
}