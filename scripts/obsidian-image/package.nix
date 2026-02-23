{
    lib,
    pkgs,
    ...
}: let
    img-process = pkgs.writers.writePython3Bin "img-process" {
        libraries = with pkgs.python3Packages; [
            pillow
            numpy
        ];

        flakeIgnore = [
            "F401"
            "E501"
        ];
    }
    ./process.py;
in
    pkgs.writers.writeFishBin "oimg"
    {
        makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            "${lib.makeBinPath [
                img-process
                pkgs.wl-clipboard
            ]}"
        ];
    }
    ''
        dms screenshot --no-clipboard --dir /tmp --filename img.png
        img-process
        wl-copy --type image/png < /tmp/img.png
    ''
