{
    pkgs,
    ...
}: {
    fonts.packages = with pkgs; [
        HelveticaNeueCyr
        SFMono
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        (google-fonts.override { fonts = [ "Inter" "Overpass" "Rubik" ]; })
    ];
}