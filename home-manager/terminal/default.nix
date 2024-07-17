{
    pkgs,
    ...
}: {
    imports = [
        ./bash.nix
        ./devenv.nix
        ./ffmpeg.nix
        ./fish.nix
        ./gh.nix
        ./git.nix
        ./kitty.nix
        ./nix-utilities.nix
        ./starship.nix
        ./utilities.nix
        ./zsh.nix
    ];

    home.packages = with pkgs; [
    ];
}