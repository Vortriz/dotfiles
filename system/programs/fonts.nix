{
    pkgs,
    ...
}: {
    fonts.packages = with pkgs; [
        HelveticaNeueCyr
        SFMono
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        (google-fonts.override { fonts = [ "Inter" "Overpass" "Rubik" ]; })
    ];
}