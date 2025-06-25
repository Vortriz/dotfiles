{pkgs, ...}:
pkgs.writers.writePython3Bin "dl" {
    libraries = with pkgs.python3Packages; [
        requests
        beautifulsoup4
        aria2p
    ];

    flakeIgnore = ["F401" "E501" "W503"];
}
./dl.py
