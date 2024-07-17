{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
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
        thefuck
        tealdeer
        micro

        util-linux
        android-tools
    ];
}