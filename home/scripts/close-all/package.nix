{pkgs, ...}:
pkgs.writers.writePython3Bin "close-all" {
    flakeIgnore = ["F401" "E501"];
}
./close-all.py
