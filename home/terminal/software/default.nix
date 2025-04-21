{pkgs, ...}: {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ./aria2.nix
        ./direnv.nix
        ./eza.nix
        ./gh.nix
        ./git.nix
        ./micro.nix
        ./nh.nix
        ./nix-index.nix
        ./tldr.nix
        ./zoxide.nix

        ./yazi
        # keep-sorted end
    ];

    home.packages = with pkgs; [
        # keep-sorted start
        cachix
        comma
        just
        magic-wormhole
        ookla-speedtest
        pandoc
        tealdeer
        # keep-sorted end
    ];
}
