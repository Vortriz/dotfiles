{
    age.secrets."rclone" = {
        file = ./rclone.age;
        path = "/home/vortriz/.config/rclone/rclone.conf";
        symlink = false;
        mode = "666";
    };
}
