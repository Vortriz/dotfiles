{
    args = {
        lib' = {
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
        };
    };
}
