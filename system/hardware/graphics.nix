{
    pkgs,
    ...
}: {
    hardware.graphics = {
        enable = true;

        # For steam (wine)
        enable32Bit = true;

        extraPackages = with pkgs; [
            intel-media-driver
            intel-ocl
            intel-vaapi-driver
        ];
    };

    environment.systemPackages = with pkgs; [
        glxinfo
        mesa
    ];
}