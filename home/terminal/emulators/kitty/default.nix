{
    programs.kitty = {
        enable = true;

        settings = {
            window_padding_width = 8;
        };

        extraConfig = ''
            map ctrl+backspace send_text all \x17
        '';
    };
}