{
    pkgs,
    ...
}: {
    fonts.packages = with pkgs; [
        HelveticaNeueCyr
        SFMono
        (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
        (google-fonts.override { fonts = [ "Inter" "Overpass" "Rubik" ]; })
    ];
}