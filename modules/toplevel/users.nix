{
    unify.nixos = {hostConfig, ...}: {
        users.users.${hostConfig.username} = {
            isNormalUser = true;
            extraGroups = ["networkmanager" "wheel" "video"];
        };
    };
}
