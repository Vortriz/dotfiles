{
    pkgs,
    ...
}: {
    imports = [
        ./julia.nix
        ./vscode.nix
    ];

    home.packages = with pkgs; [
        devenv
        typst
        uv
    ];
}