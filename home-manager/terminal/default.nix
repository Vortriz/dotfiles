{
    pkgs,
    ...
}: {
    imports = [
        ./bash.nix
        ./devenv.nix
        ./ffmpeg.nix
        ./gh.nix
        ./git.nix
        ./utilities.nix
    ];

    home.packages = with pkgs; [
    ];
}