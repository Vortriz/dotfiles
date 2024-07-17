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
        ./kitty.nix
        ./nix-utilities.nix
        ./utilities.nix
        ./zsh.nix
    ];

    home.packages = with pkgs; [
    ];
}