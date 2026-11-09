{
    unify.nixos = {
        boot.kernelParams = [ "intel_pstate=active" ];

        # The nixpkgs module writes /etc/watt.toml, but the daemon only reads
        # --config or WATT_CONFIG and otherwise falls back to its built-in rules.
        systemd.services.watt.environment.WATT_CONFIG = "/etc/watt.toml";

        services = {
            watt = {
                enable = true;
                settings = fromTOML (builtins.readFile ./watt.toml);
            };

            # To report battery stats
            upower.enable = true;

            # Login manager
            logind.settings.Login = {
                HandlePowerKey = "suspend";
                HandlePowerKeyLongPress = "poweroff";
                HandleLidSwitch = "suspend-then-hibernate";
            };
        };
    };
}
