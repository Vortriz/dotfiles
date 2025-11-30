{lib, ...}: {
    unify.options.username = lib.mkOption {
        type = lib.types.str;
        default = "vortriz";
    };
}
