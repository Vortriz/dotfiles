{
    pkgs,
    ...
}: {
    imports = [
        ./yazi

        ./aria2.nix
        ./direnv.nix
        ./eza.nix
        ./gh.nix
        ./git.nix
        ./micro.nix
        ./nh.nix
        ./tldr.nix
        ./zoxide.nix
    ];

    home.packages = with pkgs; [
        cachix
        magic-wormhole
        ripgrep-all
        sd
        tealdeer
        update-nix-fetchgit
    ];

    programs.thefuck.enable = true;
}