{ pkgs, ... }:

{
    imports = [
        ./ffmpeg.nix
        ./file-manager.nix
        ./firefox/firefox.nix
        ./gimp.nix
        ./mpv.nix
        ./obsidian.nix
        ./sioyek.nix
        ./social-apps.nix
        ./steam.nix
        ./test.nix
        ./utilities.nix
        ./vlc.nix
        ./wine.nix
        ./youtube-music.nix
    ];
}