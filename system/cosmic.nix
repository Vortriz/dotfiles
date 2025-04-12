{pkgs, ...}: {
    services.displayManager = {
        cosmic-greeter.enable = true;
        sessionPackages = [pkgs.cosmic-ext-niri];
    };
}