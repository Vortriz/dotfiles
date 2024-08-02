{
    pkgs,
    ...
}: {
    programs.mpv = {
        enable = true;
    };
    
    home.packages = with pkgs; [
        vlc
    ];
}