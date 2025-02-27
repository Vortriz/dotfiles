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
        fishPlugins.colored-man-pages
        fishPlugins.fzf-fish
        fishPlugins.sponge
        fishPlugins.z
    ];
}