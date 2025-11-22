let
    extension = shortId: extensionId: {
        name = extensionId;
        value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
        };
    };

    extensionPriv = shortId: extensionId: {
        name = extensionId;
        value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
            private_browsing = true;
        };
    };
in {
    programs.firefox.policies.ExtensionSettings = builtins.listToAttrs [
        # find in source page by `byGUID`
        # keep-sorted start
        (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
        (extension "darkreader" "addon@darkreader.org")
        (extension "istilldontcareaboutcookies" "idcac-pub@guus.ninja")
        (extension "markdown-here" "markdown-here-webext@adam.pritchard")
        (extension "raindropio" "jid0-adyhmvsP91nUO8pRv0Mn2VKeB84@jetpack")
        (extension "sponsorblock" "sponsorBlocker@ajay.app")
        (extension "tabliss" "extension@tabliss.io")
        (extension "userchrome-toggle-extended" "userchrome-toggle-extended@n2ezr.ru")
        (extensionPriv "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
        (extensionPriv "ublock-origin" "uBlock0@raymondhill.net")
        # keep-sorted end
    ];
}
