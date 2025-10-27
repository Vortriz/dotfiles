{lib, ...}: {
    options = {
        custom-lib = lib.mkOption {
            default = {};

            type = lib.types.attrs;

            description = ''
                This option allows modules to define helper functions, constants, etc.
            '';
        };
    };

    config = {
        custom-lib = {
            xdgAssociations = type: program: list:
                builtins.listToAttrs (map (e: {
                    name = "${type}/${e}";
                    value = program;
                })
                list);
        };
    };
}
