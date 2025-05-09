{
    programs.nh = {
        enable = true;

        clean = {
            enable = false; # vacation # TODO: preserve project roots

            extraArgs = "--keep 5";
        };
    };
}
