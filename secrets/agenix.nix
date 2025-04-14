{config, ...}: let
    username = config.var.username;
in {
    age.secrets."rclone" = {
        file = ./rclone.age;
        path = "/home/${username}/.config/rclone/rclone.conf";
        symlink = false;
        mode = "666";
    };
}
