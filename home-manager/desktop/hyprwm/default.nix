{
    pkgs,
    inputs,
    ...
}: {
    wayland.windowManager.hyprland = {
        enable = true;

        plugins = [
            inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
            inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
            inputs.hyprgrass.packages.${pkgs.system}.default
        ];
    };

    home.packages = with pkgs; [
        hyprpicker
    ];

    programs.hyprlock = {
        enable = true;
        package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    };
}