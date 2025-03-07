{
    pkgs,
    ...
}: {
    imports = [
        ./aria2.nix
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
        nvd
        wl-clipboard
    ];
}