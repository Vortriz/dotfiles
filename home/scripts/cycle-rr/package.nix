{pkgs, ...}:
pkgs.writers.writePython3Bin "cycle-rr" {
    libraries = with pkgs.python3Packages; [
        desktop-notifier
    ];

    flakeIgnore = ["F401" "E501"];
}
./cycle-rr.py
