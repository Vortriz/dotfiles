{ pkgs, inputs, ... }:

{
    home.packages = [ pkgs.vscode ];

    programs.vscode = {
        enable = true;
    };
}
