# SETUP (Notes to self)

+ Boot into ISO
+ Connect to non-institute wifi
+ Procced to install NixOS and make sure to label the root partition as ROOT and boot partition as SYSTEM
+ Enter nix shell having git with `nix-shell -p git`. Then clone dotfiles with `git clone https://github.com/Vortriz/dotfiles` and exit the shell.
+ Then cd into `dotfiles` and enter `nix develop --extra-experimental-features "flakes nix-command"`. Run `bash post-install`.
+ Run `just deploy` to finish off.

## Post install

+ Rekey Agenix

# FIX broken setup

+ Boot into ISO and connect to wifi
+ Mount root partition like `mount <ROOT> /mnt` and boot as `mount <BOOT> /mnt/boot`
+ Then `nixos-enter`
+ Fix whatever you messed up
+ Rebuild `boot` with `--option sandbox false` option
