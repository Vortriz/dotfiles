{
    imports = [
        ./aliases.nix
        ./config.nix
        ./launchers.nix
    ];

    programs.sherlock.enable = true;

    home.file.".config/sherlock/main.css".text = with builtins;
        readFile (fetchurl {
            url = "https://raw.githubusercontent.com/Skxxtz/sherlock/refs/heads/documentation/resources/main.css";
            sha256 = "sha256-0K6KiNBq26Yvf2epkJNj9Yc/C6F3KQ6xXCrbbj0bTwM=";
        });
}
