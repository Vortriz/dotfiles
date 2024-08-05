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

        extraConfig = ''
            map ctrl+backspace send_text all \x17
        '';
    };
}