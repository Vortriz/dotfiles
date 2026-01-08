{
    unify.nixos = {
        lib,
        pkgs,
        ...
    }: {
        environment.systemPackages = [pkgs.fresh-editor];
        environment.variables = {
            EDITOR = lib.mkForce "fresh";
        };
    };
}
