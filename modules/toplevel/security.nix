{
    unify.nixos = {
        security = {
            # for sound and something else too
            rtkit.enable = true;

            pam.services = {
                login.enableGnomeKeyring = true;
                gdm.enableGnomeKeyring = true;
                hyprlock = {};
            };

            # oxidizing sudo
            sudo-rs.enable = true;
            sudo.enable = false;
        };
    };
}
