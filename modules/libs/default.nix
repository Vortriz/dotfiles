{
    args = {
        lib' = {
            xdgAssociations = program: type: list:
                builtins.listToAttrs (map (e: {
                    name = "${type}/${e}";
                    value = program;
                })
                list);
        };
    };
}
