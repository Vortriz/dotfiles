{ pkgs, ... }:

{
    home.packages = with pkgs; [
        (catppuccin-kvantum.override {
        accent = "Blue";
        variant = "Macchiato";
        })
        libsForQt5.qtstyleplugin-kvantum
        libsForQt5.qt5ct
    ];

    qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";
    };

    xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
        General.theme = "Catppuccin-Macchiato-Blue";
    };
}