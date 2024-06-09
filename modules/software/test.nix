{ pkgs, ... }:

{
   home.packages = with pkgs; [ hw-probe stress dmidecode hwinfo maliit-keyboard corectrl ];
}