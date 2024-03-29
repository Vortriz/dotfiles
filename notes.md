# things to note

`environment.systemPackages` installs system wide

`users.users.rishi.packages` installs for user

`home.packages` installs for user and managed by home manager

`program.enable` does the same as `home.packages = [ pkgs.program ]`

> All three use packages from nixpkgs database; its just that home-manager allows extra configuration via options

# programs to install

verify package names

- ~~pulseeffects~~
- ~~ffmpeg~~
- ~~asusctl~~
- ~~preload~~
- ~~thunderbolt~~
- autocpu-freq
- gimp