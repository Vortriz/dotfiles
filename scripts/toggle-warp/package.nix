{pkgs, ...}:
pkgs.writers.writePython3Bin "toggle-warp" {
    libraries = with pkgs.python3Packages; [
        desktop-notifier
    ];

    flakeIgnore = ["F401" "E501"];
}
./toggle-warp.py
