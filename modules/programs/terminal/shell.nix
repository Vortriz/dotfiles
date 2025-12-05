{
    unify = {
        nixos = {
            hostConfig,
            pkgs,
            ...
        }: {
            programs.fish.enable = true;

            users.users.${hostConfig.username}.shell = pkgs.fish;
        };

        home = {pkgs, ...}: {
            programs.fish = {
                enable = true;

                plugins = map (plugin: {
                    name = plugin.pname;
                    inherit (plugin) src;
                }) (with pkgs.fishPlugins; [
                    autopair
                    colored-man-pages
                    fish-bd
                    fzf-fish
                    puffer
                    sponge
                ]);
            };

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

            programs.bash.enable = true;
        };
    };
}
