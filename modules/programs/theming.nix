{inputs, ...}: {
    unify = {
        nixos = {pkgs, ...}: {
            imports = [inputs.stylix.nixosModules.stylix];

            stylix = {
                enable = true;
                autoEnable = false;

                polarity = "dark";

                base16Scheme = {
                    base00 = "0d1117"; # Default bg
                    base01 = "161b22"; # Lighter bg (status bar, line number, folding mks)
                    base02 = "282e37"; # Selection bg
                    base03 = "899296"; # Comments, invisibles, line hl
                    base04 = "c6cdd5"; # Dark fg (status bars)
                    base05 = "ecf2f8"; # Default fg (caret, delimiters, Operators)
                    base06 = "d3dbe3"; # Light fg (not often used)
                    base07 = "dde5ed"; # Light bg (not often used)
                    base08 = "b392e9"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
                    base09 = "ffab70"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
                    base0A = "ffdf5d"; # Classes, Markup Bold, Search Text Background
                    base0B = "a5d6ff"; # Strings, Inherited Class, Markup Code, Diff Inserted
                    base0C = "89dceb"; # Support, regex, escape chars
                    base0D = "6ab1f0"; # Function, methods, headings
                    base0E = "f38ba8"; # Keywords
                    base0F = "85e89d"; # Deprecated, open/close embedded tags
                };

                opacity = {
                    applications = 0.75;
                    terminal = 0.75;
                };

                fonts = {
                    serif = {
                        package = pkgs.libertinus;
                        name = "Libertinus Serif";
                    };

                    sansSerif = {
                        package = pkgs.google-fonts.override {fonts = ["Lato"];};
                        name = "Lato";
                    };

                    monospace = {
                        package = pkgs.maple-mono.Normal-NF-unhinted;
                        name = "Maple Mono Normal NF";
                    };

                    emoji = {
                        package = pkgs.noto-fonts-emoji;
                        name = "Noto Color Emoji";
                    };

                    sizes = {
                        applications = 12;
                        terminal = 12;
                    };
                };
            };
        };

        home = {pkgs, ...}: {
            stylix = {
                enable = true;
                autoEnable = false;

                targets = {
                    gtk.enable = true;
                    kde.enable = false; # doesnt work for qt6 for now
                };
            };

            home.pointerCursor = {
                package = pkgs.bibata-cursors;
                name = "Bibata-Modern-Classic";
                size = 24;
            };

            gtk = {
                enable = true;

                iconTheme = {
                    package = pkgs.adwaita-icon-theme;
                    name = "Adwaita";
                };
            };
        };
    };
}
