{
    lib,
    osConfig,
    config,
    ...
}: let
    inherit (osConfig.var) username storageDir;
    inherit (config.xdg) configHome dataHome cacheHome;
in {
    imports = lib.filesystem.listFilesRecursive ./. |> lib.filter (f: baseNameOf f == "default.nix");

    home = {
        inherit username;
        homeDirectory = "/home/" + username;
    };

    programs.home-manager = {
        enable = true;
        # path = "${osConfig.var.storageDir}/dev/nix/home-manager";
    };

    home.sessionVariables = {
        # Set uv cache directory
        UV_CACHE_DIR = "${storageDir}/dev/.cache/uv";

        CARGO_HOME = "${dataHome}/cargo";

        GTK2_RC_FILES = lib.mkForce "${configHome}/gtk-2.0/gtkrc";

        JULIA_DEPOT_PATH = "${dataHome}/julia:$JULIA_DEPOT_PATH";

        NPM_CONFIG_INIT_MODULE = "${configHome}/npm/config/npm-init.js";
        NPM_CONFIG_CACHE = "${cacheHome}/npm";
        NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";

        RUSTUP_HOME = "${dataHome}/rustup";
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "24.11";
}
