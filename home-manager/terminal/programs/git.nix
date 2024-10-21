{
    pkgs,
    ...
}: {
    programs.git = {
        enable = true;
        userName = "Rishi Vora";
        userEmail = "vorarishi22@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };
}
