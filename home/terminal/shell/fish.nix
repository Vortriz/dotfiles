{pkgs, ...}: {
    programs.fish = {
        enable = true;

        shellAliases = {
            cd = "zoxide";
        };
    };

    home.packages = with pkgs.fishPlugins;
        [
            # keep-sorted start
            autopair
            colored-man-pages
            fish-bd
            fzf-fish
            puffer
            sponge
            # keep-sorted end
        ]
        ++ (with pkgs; [
            # keep-sorted start
            bat
            fd
            fzf
            # keep-sorted end
        ]);

    home.sessionVariables = {
        fzf_preview_dir_cmd = "eza -1 --all";
        sponge_allow_previously_successful = "false";
    };

    stylix.targets.fish.enable = true;
}
