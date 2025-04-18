{pkgs, ...}: {
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
        just
        magic-wormhole
        ookla-speedtest
        pandoc
        superfile
        tealdeer
    ];
}
