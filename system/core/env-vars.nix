{
    environment.variables = {
        EDITOR = "micro";

        # For nh
        FLAKE = "$HOME/dotfiles/";

        # For OpenGL applications in shell.nix/flake.nix (looking at you GLMakie)
        LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
    };
}