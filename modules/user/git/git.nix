{ pkgs, inputs, ... }:

{
    home.packages = [ pkgs.git ];

    programs.git = {
        enable = true;
        userName = "Rishi";
        userEmail = "vorarishi22@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };
}
