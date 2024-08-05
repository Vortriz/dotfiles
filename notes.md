# notes to self

- Hyprland won't work unless 3D acceleration is enabled. And apparently, Hyprland does not work in a VM,
- Steps for devenv
  - (first time) run `$ cachix use nixpkgs-python`
  - start a shell with `devenv init`
  - for python, run `devenv inputs add nixpkgs-python github:cachix/nixpkgs-python --follows nixpkgs`
  - run `which python` and paste the path into *Select Interpreter...*
- TODO: streamline it

# things to check out

- [x] ~~alejandra~~ (not ready for prime time)
- [x] nh
- [x] ~~nix-output-monitor~~ (already in nh)
- [x] ~~nvd~~ (already in nh)
- [x] ~~nixd~~ (dont need ig)
- [ ] nix-index
- [x] comma
- [x] ~~zed~~ (doesn't work)
- [x] kitty
- [x] fish
- [x] starship
- lf/yazi/mc
- [x] z
- [x] fzf
- [x] sd
- [x] ~~just~~ (dont need rn ig)
- [x] ~~kondo~~ (dont need ig)
- [x] ~~zoxide~~ (ig i'll stick to z)
- [x] ripgrep-all
- [x] eza
- [x] bat
- btop++
- taskmaster
- [x] thefuck
- [x] tealdeer
- [x] micro
- [x] ~~diffuse/meld~~ (dont need ig)
- [x] util-linux
- [x] android-tools
- some drive sync utility
- [x] ventoy-full
- [x] anydesk
- [x] kde partition manager
- [x] ksystemlog
- [x] onlyoffice

## theming

- [ ] hyprland
- [ ] kitty

## programming/typesetting

- [x] python
- [x] jupyter
- [ ] typst

# things to do

- [ ] video conferencing
  - [ ] camera
  - [ ] microphone
  - [ ] screen sharing
- [ ] screenshot workflow
- [ ] sound
- [ ] devenv/direnv workflow
- [ ] nixos-rebuild switch logging (make a logfile with deployment timestamp and commit it)