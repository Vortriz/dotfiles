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

        ./anifetch
        ./nix-search-tv
        ./yazi
        # keep-sorted end
    ];

    home.packages = with pkgs; [
        # keep-sorted start
        cachix
        just
        magic-wormhole
        ookla-speedtest
        pandoc
        rclone
        # keep-sorted end
    ];
}
