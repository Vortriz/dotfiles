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
        devenv
        ffmpeg
        imagemagick
        magic-wormhole
        nh
        uv
        wl-clipboard
    ];
}