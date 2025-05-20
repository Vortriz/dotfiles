{
    programs.zoxide = {
        enable = true;

        options = ["--cmd cd"];
    };

    programs.fish.shellAliases = {
        cd = "zoxide";
    };
}
