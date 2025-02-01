{
    security = {
        pam.services = {
            kwallet = {
                name = "kdewallet";
                enableKwallet = false;
            };
        };

        # for sound and something else too
        rtkit.enable = true;

        # idk
        polkit = {
            enable = true;
        };
    };
}