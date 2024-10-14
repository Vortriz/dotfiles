{
    security = {
        pam.services = {
            kwallet = {
                name = "kdewallet";
                enableKwallet = false;
            };

            # For hyprlock to work
            # hyprlock = {};
        };

        # for sound and something else too
        rtkit.enable = true;

        # Allow udisks2 to mount devices without authentication
        # for users in the "wheel" group. (to auto mount other partitions)
        polkit = {
            enable = true;
            extraConfig = ''
                polkit.addRule(function(action, subject) {
                    if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
                        action.id == "org.freedesktop.udisks2.filesystem-mount") &&
                        subject.isInGroup("wheel")) {
                        return polkit.Result.YES;
                    }
                });
            '';
        };
    };
}