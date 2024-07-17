{
    pkgs,
    ...
}: {
    programs = {
        nix-index.enable = true;
    };

    home.packages = with pkgs; [
        nh
        comma
    ];
}