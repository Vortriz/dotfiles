{
    config,
    lib,
    ...
}:
with lib; let
    cfg = config.programs.anifetch;
in {
    options.programs.anifetch = {
        enable = mkEnableOption "anifetch";

        package = mkOption {
            type = types.package;
            description = "anifetch package to use";
        };
    };

    config = mkIf cfg.enable {
        home.packages = [cfg.package];
    };
}
