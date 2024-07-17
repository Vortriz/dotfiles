{
    pkgs,
    ...
}: {
    imports = [
        ./firefox
        ./gimp.nix
        ./mpv.nix
        ./obsidian.nix
        ./onlyoffice.nix
        ./persepolis.nix
        ./sioyek.nix
        ./social-apps.nix
        ./steam.nix
        ./utilities.nix
        ./vlc.nix
        ./vscode.nix
        ./warp.nix
        ./yt-music.nix
    ];

    home.packages = with pkgs; [
    ];
}