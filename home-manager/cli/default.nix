{
    pkgs,
    ...
}: {
    imports = [
        ./ffmpeg.nix
        ./gh.nix
        ./git.nix
        ./utilities.nix
    ];

    home.packages = with pkgs; [
    ];
}