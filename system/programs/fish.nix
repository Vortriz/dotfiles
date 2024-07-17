{
    pkgs,
    ...
}: {
    programs.fish = {
        enable = true;
    };

    environment.systemPackages = with pkgs; [
        fishPlugins.z
        fishPlugins.fzf-fish
        fishPlugins.sponge
        fishPlugins.colored-man-pages
    ];

    # users.defaultUserShell = pkgs.fish; ! DON'T do this, it might break the system
}