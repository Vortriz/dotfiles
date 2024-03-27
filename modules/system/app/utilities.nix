{ inputs, config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [ 
        unzip
        hello
        ];
}