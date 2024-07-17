{
    pkgs,
    ...
}: {
    programs = {
        nh.enable = true;
        nix-index.enable = true;
    };

    home.programs = {
        comma
    };
}