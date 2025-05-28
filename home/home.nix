{
    lib,
    osConfig,
    ...
}: let
    inherit (osConfig.var) username;
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

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # For setting default applications
    xdg.mimeApps.enable = true;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "24.11";
}
