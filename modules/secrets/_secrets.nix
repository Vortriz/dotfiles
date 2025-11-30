let
    user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHeD9Bj8KaY0biIxyM9sxt681vZ0VyRZ3TXcHxuY9w9V";
in {
    # [TODO] the filename may not work
    # keep-sorted start
    "rclone.age".publicKeys = [user];
    # keep-sorted end
}
