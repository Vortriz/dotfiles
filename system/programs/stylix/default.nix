{
    # lib,
    pkgs,
    config,
    ...
}: {
    stylix = {
        enable = true;
        autoEnable = false;

        targets = {
            fish.enable = false;
            gtk.enable = false;
        };

        image = ./katana-wallpaper.jpg;

        base16Scheme = {
            base00 = "0B0A10"; # base
            base01 = "0D0B16"; # mantle
            base02 = "313244"; # surface0
            base03 = "45475a"; # surface1
            base04 = "585b70"; # surface2
            base05 = "cdd6f4"; # text
            base06 = "f5e0dc"; # rosewater
            base07 = "b4befe"; # lavender
            base08 = "f38ba8"; # red
            base09 = "fab387"; # peach
            base0A = "f9e2af"; # yellow 
            base0B = "a6e3a1"; # green
            base0C = "94e2d5"; # teal
            base0D = "89b4fa"; # blue
            base0E = "cba6f7"; # mauve
            base0F = "f2cdcd"; # flamingo
        };

        fonts = {
            serif = config.stylix.fonts.sansSerif;

            sansSerif = {
                package = pkgs.HelveticaNeueCyr;
                name = "HelveticaNeueCyr";
            };

            monospace = {
                package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
                name = "FiraCode Nerd Font Mono";
            };

            emoji = {
                package = pkgs.noto-fonts-emoji;
                name = "Noto Color Emoji";
            };
        };
    };
}