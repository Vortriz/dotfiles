{
    pkgs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        linux-wifi-hotspot
    ];
}