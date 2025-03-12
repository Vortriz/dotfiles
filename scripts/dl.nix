{
    pkgs,
    ...
}: let
    dl-script = pkgs.writers.writePython3Bin "dl" {
        libraries = with pkgs.python312Packages; [
            requests
            beautifulsoup4
            aria2p
        ];

        flakeIgnore = [ "F401" "E501" ];
    } ./dl.py;
in {
    home.packages = [
        dl-script
    ];
}
