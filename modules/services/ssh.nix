{
    unify.nixos = {hostConfig, ...}: {
        services.openssh = {
            enable = true;

            settings = {
                AllowUsers = [hostConfig.username];
                # Opinionated: forbid root login through SSH.
                PermitRootLogin = "no";
                # Opinionated: use keys only.
                # Remove if you want to SSH using passwords
                PasswordAuthentication = false;
            };
        };
    };
}
