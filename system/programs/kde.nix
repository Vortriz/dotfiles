{
    pkgs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        kdePackages.ksystemlog
        kdePackages.partitionmanager
    ];
}