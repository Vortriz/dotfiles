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
            watershot-git
            imagemagick
            wl-clipboard
        ])}"
    ];
} ''
    watershot path /tmp/img.png
    magick /tmp/img.png -negate -fuzz 20% -transparent black /tmp/img-processed.png && rm /tmp/img.png
    wl-copy < /tmp/img-processed.png && rm /tmp/img-processed.png
''
