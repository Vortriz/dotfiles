{
    programs.nh = {
        enable = true;

        clean = {
            enable = true;

            extraArgs = "--keep 5 --optimise --no-gcroots";
        };
    };
}
