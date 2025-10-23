{
    lib,
    pkgs,
    ...
}: let
    oimg-process = pkgs.writers.writePython3Bin "obsidian-img-process" {
        libraries = with pkgs.python3Packages; [
            pillow
            numpy
        ];

        flakeIgnore = ["F401" "E501"];
    }
    ./process.py;
in
    pkgs.writers.writeFishBin "oimg" {
        makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            "${lib.makeBinPath [
                oimg-process
                pkgs.wl-clipboard
            ]}"
        ];
    } ''
        niri msg action screenshot --show-pointer false --path /tmp/img.png
        sleep 5
        obsidian-img-process
        wl-copy --type image/png < /tmp/img.png
    ''
