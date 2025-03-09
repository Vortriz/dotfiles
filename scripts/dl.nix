{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeFishBin "dl" { } ''
            ${pkgs.aria2}/bin/aria2c $argv
            post-dl
        '')
    ];
}
