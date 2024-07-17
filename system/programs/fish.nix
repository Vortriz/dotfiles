{
    pkgs,
    ...
}: {
    programs.fish = {
        enable = true;
    };
    # users.defaultUserShell = pkgs.fish; ! DON'T do this, it might break the system
}