let
    user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA8LhZFvc5rrYsyhRs6knNTAPnW0+7/JKCXeuqNgSjKY root";
in {
    "rclone.age".publicKeys = [user];
}
