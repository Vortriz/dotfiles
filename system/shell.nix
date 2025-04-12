{pkgs, ...}: {
    programs = {
        bash = {
            # Launches fish unless the parent process is already fish (to keep login shell as bash)
            interactiveShellInit = ''
                if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
                then
                shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
                exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
                fi
            '';
        };

        fish = {
            enable = true;
        };

        zsh = {
            enable = true;

            enableCompletion = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
        };
    };
}
