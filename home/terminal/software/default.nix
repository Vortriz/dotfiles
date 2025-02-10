{
    pkgs,
    ...
}: {
    imports = [
        ./direnv.nix
        ./eza.nix
        ./gh.nix
        ./git.nix
        ./tldr.nix
        ./yazi.nix
    ];

    home.packages = with pkgs; [
        cachix
        ffmpeg
        imagemagick
        magic-wormhole
        nh
        wl-clipboard
    ];
}