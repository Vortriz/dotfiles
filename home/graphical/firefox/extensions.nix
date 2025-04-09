{
    programs.firefox.policies.ExtensionSettings = with builtins; let
        extension = shortId: extension_id: {
            name = extension_id;
            value = {
                install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                installation_mode = "normal_installed";
            };
        };
    in
        listToAttrs [
            # find in source page by `byGUID`
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            (extension "darkreader" "addon@darkreader.org")
            (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
            (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
            (extension "tabliss" "extension@tabliss.io")
            (extension "istilldontcareaboutcookies" "idcac-pub@guus.ninja")
            (extension "raindropio" "jid0-adyhmvsP91nUO8pRv0Mn2VKeB84@jetpack")
            (extension "sponsorblock" "sponsorBlocker@ajay.app")
            (extension "userchrome-toggle-extended" "userchrome-toggle-extended@n2ezr.ru")
            (extension "markdown-here" "markdown-here-webext@adam.pritchard")
        ];
}
