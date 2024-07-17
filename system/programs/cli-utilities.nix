{
    pkgs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        neofetch

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

        util-linux
        android-tools
    ];

    programs.thefuck = {
        enable = true;
        alias = "fuck";
    };
}