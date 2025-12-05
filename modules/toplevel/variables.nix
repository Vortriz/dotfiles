{
    unify.nixos = {
        environment.variables = {
            # For OpenGL applications in shell.nix/flake.nix (looking at you GLMakie)
            # [TODO] can this be better placed or is this even needed now?
            LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
        };
    };
}
