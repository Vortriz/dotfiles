{ pkgs, ... }:

{
    imports = [
        ./ffmpeg.nix
        ./file-manager.nix
        ./firefox.nix
        ./gimp.nix
        ./obsidian.nix
        ./sioyek.nix
        ./social-apps.nix
        ./steam.nix
        ./utilities.nix
        ./vlc.nix
        ./wine.nix
        ./youtube-music.nix
    ];
}