{
    unify.nixos = _: {
        documentation = {
            doc.enable = false;
            info.enable = false;
        };

        time.timeZone = "Asia/Kolkata";
        i18n = {
            defaultLocale = "en_IN";
            extraLocales = ["en_US.UTF-8/UTF-8"];
        };

        # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        system.stateVersion = "25.11";
    };
}
