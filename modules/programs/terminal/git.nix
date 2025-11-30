{
    unify.home = {
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

        programs.gh = {
            enable = true;

            settings = {
                editor = "code --wait";
                git_protocol = "https";
            };
        };

        programs.gitui.enable = true;

        stylix.targets.gitui.enable = true;
    };
}
