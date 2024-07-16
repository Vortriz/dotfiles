# notes to self

- Hyprland won't work unless 3D acceleration is enabled. And apparently, Hyprland does not work in a VM,
- Steps for devenv
  - (first time) run `$ cachix use nixpkgs-python`
  - start a shell with `devenv init`
  - for python, run `devenv inputs add nixpkgs-python github:cachix/nixpkgs-python --follows nixpkgs`
  - run `which python` and paste the path into *Select Interpreter...*
- TODO: streamline it