# things to note

`environment.systemPackages` installs system wide

`users.users.rishi.packages` installs for user

`home.packages` installs for user and managed by home manager

`program.enable` does the same as `home.packages = [ pkgs.program ]`

> All three use packages from nixpkgs database; its just that home-manager allows extra configuration via options

 Installing a package via `environment.systemPackages` simply puts a binary in your PATH that you can run, together with all necessary dependencies.

However, the above doesn't include any configuration (other than whatever defaults the package ships with), and you then have to manually configure it. Installing a package via a `programs.package` also offers configuration options. Then, in addition to installing the package, NixOS automatically generates config files and symlinks them in /etc or wherever they need to go. It can also ensure the system is configured properly to run the package.

Finally, `services` modules are similar to programs modules - they install a program, expose configuration options, and configure the system as needed - but they are specifically for programs that are running in the background. Enabled services will automatically start as the system boots, and will keep running while it's on. 

# programs to install

verify package names

- ~~pulseeffects~~
- ~~ffmpeg~~
- ~~asusctl~~
- ~~preload~~
- ~~thunderbolt~~
- autocpu-freq
- ~~gimp~~

# my setup

`home.nix` is imported into home-manager in `flake.nix`. so
- imports
  - some are declared using `home.packages` (no enable option, so less system access)
  - some are declared using `programs.<package>.enable` (more system access)
  - some are declared using `services.<package>.enable` (even more system access) (only used if the option is only available in home-manager)
- utilities
  - misc things

services are kept in `configuration.nix` (unless controlled by home manager options)

only very important things are in `environment.systemPackages`

# todo

follow above and verify