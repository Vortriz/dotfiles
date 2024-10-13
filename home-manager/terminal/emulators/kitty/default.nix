{
    pkgs,
    ...
}: {
    programs.kitty = {
        enable = true;
        # font = {
        #     name = "FiraCode Nerd Font Mono";
        #     size = 12;
        # };

        # settings = import ./theme-oledppuccin-mocha.nix;

        settings = {
            window_padding_width = 8;
        };

        extraConfig = ''
            map ctrl+backspace send_text all \x17
        '';
    };
}