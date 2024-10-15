{
    pkgs,
    inputs,
    config,
    ...
}: let
    # for nbfc
    # myUser = "rishi"; #adjust this to your username
    # command = "bin/nbfc_service --config-file '/home/${myUser}/.config/nbfc.json'";
in {
    environment.systemPackages = with pkgs; [
        asusctl

        neofetch
        pfetch

        unzip
        p7zip
        rar

        fzf
        fd
        bat
        sd
        ripgrep-all
        eza
        tealdeer
        micro

        lm_sensors
        util-linux
        pciutils

        android-tools

        # inputs.nbfc-linux.packages.x86_64-linux.default
    ];

    programs.thefuck = {
        enable = true;
        alias = "fuck";
    };

    # for nbfc
    # systemd.services.nbfc_service = {
    #     enable = true;
    #     description = "NoteBook FanControl service";
    #     serviceConfig.Type = "simple";
    #     path = [pkgs.kmod];
    #     script = "${inputs.nbfc-linux.packages.x86_64-linux.default}/${command}";
    #     wantedBy = ["multi-user.target"];
    # };
}