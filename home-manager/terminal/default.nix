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
        ./nix-utilities.nix
        ./utilities.nix
    ];

    home.packages = with pkgs; [
    ];
}