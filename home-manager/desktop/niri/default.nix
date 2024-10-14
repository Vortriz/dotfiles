{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        polkit-kde-agent
    ];

    programs.niri = {
        # settings.binds = {
        #     "Mod+Space".action.spawn = "fuzzel";
        # };
        config = builtins.readFile ./config.kdl;
    };
}