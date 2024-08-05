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
            gtk.enable = true;
        };

        image = ./katana-wallpaper.jpg;

        base16Scheme = {
            base00 = "0d1117"; # Default bg
            base01 = "161b22"; # Lighter bg (status bar, line number, folding mks)
            base02 = "21262d"; # Selection bg
            base03 = "899296"; # Comments, invisibles, line hl
            base04 = "c6cdd5"; # Dark fg (status bars)
            base05 = "ecf2f8"; # Default fg (caret, delimiters, Operators)
            base06 = "d3dbe3"; # Light fg (not often used)
            base07 = "dde5ed"; # Light bg (not often used)
            base08 = "B392E9"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
            base09 = "ffab70"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
            base0A = "ffdf5d"; # Classes, Markup Bold, Search Text Background
            base0B = "a5d6ff"; # Strings, Inherited Class, Markup Code, Diff Inserted
            base0C = "89dceb"; # Support, regex, escape chars
            base0D = "6AB1F0"; # Function, methods, headings
            base0E = "f38ba8"; # Keywords
            base0F = "85e89d"; # Deprecated, open/close embedded tags
        };

        # base16Scheme = {
        #     base00 = "0B0A10"; # base
        #     base01 = "0D0B16"; # mantle
        #     base02 = "313244"; # surface0
        #     base03 = "45475a"; # surface1
        #     base04 = "585b70"; # surface2
        #     base05 = "cdd6f4"; # text
        #     base06 = "f5e0dc"; # rosewater
        #     base07 = "b4befe"; # lavender
        #     base08 = "f38ba8"; # red
        #     base09 = "fab387"; # peach
        #     base0A = "f9e2af"; # yellow
        #     base0B = "a6e3a1"; # green
        #     base0C = "94e2d5"; # teal
        #     base0D = "89b4fa"; # blue
        #     base0E = "cba6f7"; # mauve
        #     base0F = "f2cdcd"; # flamingo
        # };

        fonts = {
            serif = config.stylix.fonts.sansSerif;

            sansSerif = {
                package = pkgs.google-fonts.override { fonts = [ "Lato" ]; };
                name = "Lato";
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