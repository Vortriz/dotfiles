{
    programs.firefox = {
        profiles.default.settings = {
            "app.normandy.api_url" = "";
            "app.normandy.enabled" = false; # https://mozilla.github.io/normandy/
            "app.shield.optoutstudies.enabled" = false;
            "beacon.enabled" = false; # Disable "beacon" asynchronous HTTP transfers (used for analytics)
            "breakpad.reportURL" = ""; # Disable crash reports
            "browser.aboutConfig.showWarning" = false; # I know what I'm doing
            "browser.crashReports.unsubmittedCheck.autoSubmit2" = false; # don't submit backlogged reports
            "browser.download.useDownloadDir" = false; # Ask where to save stuff
            "browser.ping-centre.telemetry" = false;
            "browser.startup.page" = 3; # Resume previous session on startup
            "browser.tabs.crashReporting.sendReport" = false;
            "browser.urlbar.suggest.bookmark" = false;
            "browser.urlbar.suggest.engines" = false;
            "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;
            "browser.urlbar.suggest.trending" = false;
            "browser.urlbar.update2.engineAliasRefresh" = true;
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false; # Disable health reports (basically more telemetry)
            "datareporting.policy.dataSubmissionEnabled" = false;
            "devtools.browserconsole.filter.css" = true;
            "devtools.chrome.enabled" = true;
            "devtools.debugger.remote-enabled" = true;
            "experiments.enabled" = false;
            "experiments.manifest.uri" = "";
            "experiments.supported" = false;
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "mousewheel.default.delta_multiplier_x" = 10;
            "mousewheel.default.delta_multiplier_y" = 20;
            "signon.rememberSignons" = false; # Don't prompt me, I use Bitwarden
            "toolkit.coverage.endpoint.base" = "";
            "toolkit.coverage.opt-out" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Allow userCrome.css
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.coverage.opt-out" = true;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.server" = "data:,";
            "toolkit.telemetry.unified" = false;
            "ui.systemUsesDarkTheme" = 1;
            "widget.use-xdg-desktop-portal.file-picker" = 1;
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
        };
    };
}
