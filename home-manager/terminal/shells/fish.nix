{
    pkgs,
    ...
}: {
    programs.fish = {
        enable = true;

        shellAliases = {
            "fp" = "fd . '/run/media/PRIMARY' | fzf --delimiter='/' --with-nth 5.. --wrap";
            "fs" = "fd . '/run/media/SECONDARY' | fzf --delimiter='/' --with-nth 5.. --wrap";
            "fv" = "fd . '/run/media/SECONDARY/nonlinear vault' | fzf --delimiter='/' --with-nth 6.. --wrap";
            "op" = "open $(fp)";
            "os" = "open $(fs)";
            "ov" = "open $(fv)";
        };
    };
}