{
    programs.nh = {
        enable = true;

        clean = {
            enable = true;

            extraArgs = "--keep 4 --optimise --no-gcroots";
        };
    };
}
