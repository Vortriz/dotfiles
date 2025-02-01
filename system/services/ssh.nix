{
    # TODO: This setups a SSH server. Very important if you're setting up a headless system.
    services.openssh = {
        enable = false;

        settings = {
            # Opinionated: forbid root login through SSH.
            PermitRootLogin = "no";
            # Opinionated: use keys only.
            # Remove if you want to SSH using passwords
            PasswordAuthentication = false;
        };
    };
}