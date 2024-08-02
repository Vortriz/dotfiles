{
    lib,
    pkgs,
    inputs,
    ...
}: {
    wayland.windowManager.hyprland = {
        enable = true;

        plugins = with pkgs.hyprlandPlugins; [
            hyprbars
            hyprexpo
            hyprgrass
        ];

        settings = {
            monitor = "WL-1, 1920x1200@90, 0x0, 1, bitdepth, 10";
            bind = [
                "SUPER_SHIFT,Q,exec,kitty"
            ];
        };
    };

    programs = {
        hyprlock = {
            enable = true;
        };
    };

    home.packages = with pkgs; [
        hyprpicker
    ];
}