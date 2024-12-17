{
    pkgs,
    ...
}: {
    fonts.packages = with pkgs; [
        HelveticaNeueCyr
        SFMono
        font-awesome
        roboto
        source-sans-pro
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        (google-fonts.override { fonts = [ "Inter" "Overpass" "Rubik" ]; })
    ];
}