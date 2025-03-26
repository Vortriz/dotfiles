{
    pkgs,
    ...
}: {
    programs.fish = {
        enable = true;

        shellAliases = {
            z = "zoxide";
        };
    };

    home.packages = with pkgs.fishPlugins; [
        autopair
        colored-man-pages
        fish-bd
        fzf-fish
        puffer
        sponge
    ] ++ (with pkgs; [
        fd
        fzf
        bat
    ]);

    home.sessionVariables = {
        fzf_preview_dir_cmd = "eza -1 --all";
        sponge_allow_previously_successful = "false";
    };

    stylix.targets.fish.enable = true;
}