let
    vortriz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFtvfDuEyf7KsXDqDVxogGmHoBCtsFDVxmkPtnphZKWH root";
in {
    "rclone.age".publicKeys = [vortriz];
}
