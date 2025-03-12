{
    pkgs,
    ...
}: let
    oimg-script = pkgs.writers.writeFishBin "oimg" {} ''
        ${pkgs.flameshot}/bin/flameshot gui -p /tmp/img.png
        ${pkgs.imagemagick}/bin/magick /tmp/img.png -negate -fuzz 20% -transparent black /tmp/img-processed.png && rm /tmp/img.png
        ${pkgs.wl-clipboard}/bin/wl-copy < /tmp/img-processed.png && rm /tmp/img-processed.png
    '';
in {
    home.packages = [
        oimg-script
    ];
}