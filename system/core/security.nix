{
    # For hyprlock to work
    security.pam.services.hyprlock = {};

    # Allow udisks2 to mount devices without authentication
    # for users in the "wheel" group. (to auto mount other partitions)
    security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
            action.id == "org.freedesktop.udisks2.filesystem-mount") &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
    '';
}