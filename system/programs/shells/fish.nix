{
    pkgs,
    ...
}: {
    stylix.targets.fish.enable = false;

    programs.fish = {
        enable = true;

        shellInit = ''
            direnv hook fish | source
        '';
    };

    environment.systemPackages = with pkgs; [
        fishPlugins.z
        fishPlugins.fzf-fish
        fishPlugins.sponge
        fishPlugins.colored-man-pages
    ];
}