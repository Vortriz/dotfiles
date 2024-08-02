{
    pkgs,
    ...
}: {
    hardware = {
        pulseaudio = {
            enable = true;
            package = pkgs.pulseaudioFull;
        };
    };
}