{pkgs, ...}: {
    programs.bash.enable = true;

    programs.fish.enable = true;

    home.packages =
        (with pkgs.fishPlugins; [
            # keep-sorted start
            autopair
            colored-man-pages
            fish-bd
            fzf-fish
            puffer
            sponge
            # keep-sorted end
        ])
        # Search Directory dependencies
        ++ (with pkgs; [
            # keep-sorted start
            bat
            fd
            fzf
            # keep-sorted end
        ]);

    home.sessionVariables = {
        fish_greeting = "";
        fzf_preview_dir_cmd = "eza -1 --all";
        sponge_allow_previously_successful = "false";
    };

    stylix.targets = {
        fish.enable = true;

        bat.enable = true;
        fzf.enable = true;
    };
}
