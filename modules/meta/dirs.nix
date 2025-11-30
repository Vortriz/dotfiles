{lib, ...}: let
    inherit (lib) mkOption types;
in {
    unify.options = {
        dirs = {
            storage = mkOption {
                type = types.str;
                default = "/mnt/HOUSE";
            };
            downloads = mkOption {
                type = types.str;
                default = "/mnt/HOUSE/downloads";
            };
        };
    };
}
