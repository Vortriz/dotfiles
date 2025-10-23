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
                pkgs.inotify-tools
            ]}"
        ];
    } ''
        niri msg action screenshot --show-pointer false --path /tmp/img.png
        inotifywait -q -e close_write /tmp/img.png
        obsidian-img-process
        wl-copy --type image/png < /tmp/img.png
    ''
