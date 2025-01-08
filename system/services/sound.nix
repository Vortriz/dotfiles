{
    pkgs,
    ...
}: {
    services = {
        pulseaudio = {
            enable = true;
            package = pkgs.pulseaudioFull;
        };
    };
}