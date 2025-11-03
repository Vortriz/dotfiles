{pkgs, ...}: {
    programs.fastfetch = {
        enable = true;
        settings = import ./config.nix;
    };

    home.packages = [pkgs.nur.repos.Vortriz.dunefetch-git];
}
