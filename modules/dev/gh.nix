{ pkgs, ... }:

{
    programs.gh = {
        enable = true;
        settings = {
            editor = "code --wait";
            git_protocol = "https";
        };
    };
}
