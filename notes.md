# notes to self

- Hyprland won't work unless 3D acceleration is enabled. And apparently, Hyprland does not work in a VM.
- Steps for devenv
  - ~~(first time) run `$ cachix use nixpkgs-python`~~
  - ~~start a shell with `devenv init`~~
  - ~~for python, run `devenv inputs add nixpkgs-python github:cachix/nixpkgs-python --follows nixpkgs`~~
  - ~~run `which python` and paste the path into *Select Interpreter...*~~
  - ~~TODO: streamline it~~
  - just run `python-setup`
- Steps to keep feature branch in parity with main branch
  - Commit all the changes `main` and push them `git checkout main && git push origin main`
  - Commit all changes to `feature` and push them `git checkout feature && git push origin feature`
  - Start rebase `git rebase main`
  - Resolve any conflicts (probably in `build.log`) and do `git rebase --continue` till everything is sorted out
  - Then push the rebase to github `git push origin niri --force`

# things to check out

- [x] ~~alejandra~~ (not ready for prime time)
- [x] nh
- [x] ~~nix-output-monitor~~ (already in nh)
- [x] ~~nvd~~ (already in nh)
- [x] ~~nixd~~ (dont need ig)
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
- [x] ventoy-full
- [x] anydesk
- [x] kde partition manager
- [x] ksystemlog
- [x] onlyoffice
- [ ] some drive sync utility
- [ ] nix-index

## theming

- [ ] ~~hyprland~~ niri
- [x] kitty
- [ ] anyrun
- [ ] waybar

## programming/typesetting

- [x] python
- [x] jupyter
- [ ] typst
- [ ] julia (using distrobox)
- [ ] scientific-fhs

# things to do

- [ ] video conferencing
  - [ ] camera
  - [ ] microphone
  - [ ] screen sharing
- [x] screenshot workflow
- [x] sound
- [ ] devenv/direnv workflow
- [x] nixos-rebuild switch logging (make a logfile with deployment timestamp and commit it)
- [ ] nixify adding `"password-store":"gnome-libsecret"` in `.vscode/argv.json`
- [ ] make program to for find and open; and remove the ton of aliases