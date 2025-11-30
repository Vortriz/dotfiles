{inputs, ...}: {
    unify.nixos = {hostConfig, ...}: let
        inherit (hostConfig) username;
    in {
        imports = [inputs.agenix.nixosModules.default];

        age.secrets."rclone" = {
            file = ./rclone.age;
            path = "/home/${username}/.config/rclone/rclone.conf";
            symlink = false;
            mode = "666";
        };
    };
}
