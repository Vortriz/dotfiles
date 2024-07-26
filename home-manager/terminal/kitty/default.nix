{
    pkgs,
    ...
}: {
    programs.kitty = {
        enable = true;
        font = {
            name = "FiraCode Nerd Font";
            size = 12;
        };

        # settings = {
        #     window_padding_width = 15;
        # };

        settings = import ./apatheia.nix;

        extraConfig = ''
            map ctrl+backspace send_text all \x17
        '';
    };
}