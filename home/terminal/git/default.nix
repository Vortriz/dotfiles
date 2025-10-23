{
    programs.git = {
        enable = true;

        settings = {
            user = {
                name = "Vortriz";
                email = "vorarishi22+github@gmail.com";
            };
            init.defaultBranch = "main";
        };
    };

    programs.gitui.enable = true;

    stylix.targets.gitui.enable = true;
}
