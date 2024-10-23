{
    pkgs,
    ...
}: {
    hardware.graphics = {
        enable = true;

        # For steam (wine)
        enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
        glxinfo
    ];
}