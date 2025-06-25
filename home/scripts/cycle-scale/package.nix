{pkgs, ...}:
pkgs.writers.writePython3Bin "cycle-scale" {
    libraries = with pkgs.python3Packages; [
        desktop-notifier
    ];

    flakeIgnore = ["F401" "E501"];
}
./cycle-scale.py
