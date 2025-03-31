{pkgs, ...}: let
    baseDir = ".mozilla/firefox/default";

    shyfox = pkgs.fetchzip {
        url = "https://github.com/z4na14/ShyFox/archive/refs/heads/main.zip";
        sha256 = "sha256-5fMWersBNRK8Taw6JFcdVhZpK5bZI32Vsaa8vqdOwPk=";
        stripRoot = true;
    };
in {
    programs.firefox = {
        enable = true;

        profiles.default = {
            settings = {
                "browser.aboutConfig.showWarning" = false; # I know what I'm doing
                "browser.download.useDownloadDir" = false; # Ask where to save stuff
                "browser.startup.page" = 3; # Resume previous session on startup
                "browser.urlbar.suggest.bookmark" = false;
                "browser.urlbar.suggest.engines" = false;
                "browser.urlbar.update2.engineAliasRefresh" = true;
                "devtools.browserconsole.filter.css" = true;
                "devtools.chrome.enabled" = true;
                "devtools.debugger.remote-enabled" = true;
                "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
                "mousewheel.default.delta_multiplier_x" = 10;
                "mousewheel.default.delta_multiplier_y" = 20;
                "signon.rememberSignons" = false; # Don't prompt me, I use Bitwarden
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Allow userCrome.css
                "ui.systemUsesDarkTheme" = 1;
                "widget.use-xdg-desktop-portal.file-picker" = 1;
            };

            search = {
                force = true;
                default = "google";
                order = ["searxng" "google" "mynixos" "github"];

                engines = let
                    engine = (args: {
                        icon = "${args.icon}";
                        updateInterval = 24 * 60 * 60 * 1000;
                        definedAliases = ["@${args.alias}"];
                        urls = [
                            {
                                template = "${args.surl}";
                                params = [
                                    {
                                        name = "q";
                                        value = "{searchTerms}";
                                    }
                                ];
                            }
                        ];
                    });
                in {
                    "bing".metaData.hidden = true;
                    "amazondotcom-us".metaData.hidden = true;

                    "google" = engine rec {
                        url = "htttps://google.com";
                        icon = "${url}/favicon.ico";
                        alias = "google";
                        surl = "${url}/search";
                    };
                    "searxng" = engine rec {
                        url = "https://search.bus-hit.me";
                        icon = "${url}/favicon.ico";
                        alias = "xng";
                        surl = "${url}/search";
                    };
                    "mynixos" = engine rec {
                        url = "https://mynixos.com";
                        icon = "${url}/favicon.ico";
                        alias = "nix";
                        surl = "${url}/search";
                    };
                    "github" = engine rec {
                        url = "https://github.com";
                        icon = "${url}/favicon.ico";
                        alias = "gh";
                        surl = "${url}/search";
                    };
                };
            };

            extraConfig = builtins.readFile "${shyfox}/user.js";
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

            ExtensionSettings = with builtins; let
                extension = shortId: extension_id: {
                    name = extension_id;
                    value = {
                        install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                        installation_mode = "normal_installed";
                    };
                };
            in
                listToAttrs [
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

    home.file = {
        "${baseDir}/chrome" = {
            source = "${shyfox}/chrome";
        };
    };
}
