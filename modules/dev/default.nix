{ pkgs, ... }:

{
    imports = [
        ./git.nix
        ./gh.nix
        ./vscode.nix
    ];
}