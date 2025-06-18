{
    lib,
    osConfig,
    ...
}: {
    programs.fastfetch = {
        enable = true;
        settings = import ./config.nix {inherit lib osConfig;};
    };
}
