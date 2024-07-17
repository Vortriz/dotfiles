{
    pkgs,
    ...
}: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
    };

    # users.defaultUserShell = pkgs.zsh;
    # environment.pathsToLink = [ "/share/zsh" ];
}   