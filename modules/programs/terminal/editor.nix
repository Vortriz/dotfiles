{
    unify.nixos = {
        lib,
        pkgs,
        ...
    }: {
        environment.systemPackages = [pkgs.fresh];
        environment.variables = {
            EDITOR = lib.mkForce "fresh";
        };
    };
}
