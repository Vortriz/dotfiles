{ inputs, lib, config, pkgs, ... }:

{
    home.packages = [ pkgs.firefox ];

    programs.firefox = {
        enable = true;
    };
}
