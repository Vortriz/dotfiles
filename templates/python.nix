{ pkgs, lib, config, inputs, ... }:

{
    languages.python = {
        enable = true;
        version = "3.10.8";

        venv = {
            enable = true;
            requirements = ./requirements.txt;
        };
    };

    packages = with pkgs; [
        git
    ];
}
