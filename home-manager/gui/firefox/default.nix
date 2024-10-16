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
                "devtools.browserconsole.filter.css" = true;
                "devtools.chrome.enabled" = true;
                "devtools.debugger.remote-enabled" = true;
                "browser.urlbar.update2.engineAliasRefresh" = true;
                "browser.urlbar.suggest.bookmark" = false;
                "browser.urlbar.suggest.engines" = false;
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

            SearchEngines = {
                Add =
                let
                    url = "https://search.bus-hit.me";
                in
                [
                    {
                        Name = "SearXNG";
                        URLTemplate = "${url}/search?q={searchTerms}";
                        Method = "GET";
                        IconURL = "${url}/static/themes/simple/img/favicon.png";
                        Alias = "@xng";
                        Description = "SearXNG is a metasearch engine that respects your privacy.";
                        SuggestURLTemplate = "${url}/autocompleter?q={searchTerms}";
                    }
                ];
            };

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
                    (extension "userchrome-toggle-extended" "userchrome-toggle-extended@n2ezr.ru")
                ];
        };
    };
}
