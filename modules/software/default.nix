{ pkgs, ... }:

{
    imports = [
        ./ffmpeg.nix
        ./firefox.nix
        ./gimp.nix
        ./kdeconnect.nix
        ./steam.nix
        ./vlc.nix
        ./vscode.nix
        ./wine.nix
        ./youtube-music.nix
    ];
}