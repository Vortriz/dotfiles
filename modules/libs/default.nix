{
    args = {
        lib' = {
            xdgAssociations = type: program: list:
                builtins.listToAttrs (map (e: {
                    name = "${type}/${e}";
                    value = program;
                })
                list);
        };
    };
}
