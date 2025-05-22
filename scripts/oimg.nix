{
    lib,
    pkgs,
    ...
}:
pkgs.writers.writeFishBin "oimg" {
    makeWrapperArgs = [
        "--prefix"
        "PATH"
        ":"
        "${lib.makeBinPath (with pkgs; [
            flameshot
            imagemagick
            wl-clipboard
        ])}"
    ];
} ''
    flameshot gui -p /tmp/img.png
    magick /tmp/img.png -negate -fuzz 20% -transparent black /tmp/img-processed.png && rm /tmp/img.png
    wl-copy < /tmp/img-processed.png && rm /tmp/img-processed.png
''
