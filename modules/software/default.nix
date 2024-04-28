{ pkgs, ... }:

{
    imports = [
        ./ffmpeg.nix
        ./firefox.nix
        ./gimp.nix
        ./steam.nix
        ./utilities.nix
        ./vlc.nix
        ./vscode.nix
        ./wine.nix
        ./youtube-music.nix
    ];
}