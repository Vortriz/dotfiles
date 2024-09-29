{
    pkgs,
    lib,
    ...
}: {
    programs.firefox = {
        enable = true;
        profiles.default = {
            settings = {
                "mousewheel.default.delta_multiplier_x" = 10;
                "mousewheel.default.delta_multiplier_y" = 20;
            };
        };

        policies = {
            DisableTelemetry = true;
            DisableFirefoxStudies = true;
            EnableTrackingProtection = {
                Value = true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = true;
            };
            DisablePocket = true;
            DisplayBookmarksToolbar = "never";
            DisplayMenuBar = "default-off";

            ExtensionSettings = with builtins;
                let extension = shortId: extension_id: {
                    name = extension_id;
                    value = {
                        install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                        installation_mode = "normal_installed";
                    };
                };
                in listToAttrs [
                    (extension "ublock-origin" "uBlock0@raymondhill.net")
                    (extension "darkreader" "addon@darkreader.org")
                    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
                    (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
                    (extension "tabliss" "extension@tabliss.io")
                    (extension "istilldontcareaboutcookies" "idcac-pub@guus.ninja")
                    (extension "raindropio" "jid0-adyhmvsP91nUO8pRv0Mn2VKeB84@jetpack")
                    (extension "sponsorblock" "sponsorBlocker@ajay.app")
                    (extension "chrome-toggle-extended" "userchrome-toggle-extended@n2ezr.ru")
                ];
        };
    };
}
