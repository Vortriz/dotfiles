{ pkgs, ... }:

{
   home.packages = with pkgs; [ hw-probe stress-ng s-tui geekbench dmidecode hwinfo corectrl linuxKernel.packages.linux_6_8.turbostat msr-tools devmem2 pciutils ];

   programs.java = {
     enable = true;
   };
}