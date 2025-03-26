{
    pkgs,
    ...
}: let
    flameshot = "${pkgs.flameshot}/bin/flameshot";
    magick = "${pkgs.imagemagick}/bin/magick";
    wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
in
    pkgs.writers.writeFishBin "oimg" {} ''
        ${flameshot} gui -p /tmp/img.png
        ${magick} /tmp/img.png -negate -fuzz 20% -transparent black /tmp/img-processed.png && rm /tmp/img.png
        ${wl-copy} < /tmp/img-processed.png && rm /tmp/img-processed.png
    ''