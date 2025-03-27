# notes to self

## Hyprland
- Hyprland won't work unless 3D acceleration is enabled. And apparently, Hyprland does not work in a VM.

## feature branch
- Steps to keep feature branch in parity with main branch
  - Commit all the changes `main` and push them `git checkout main && git push origin main`
  - Commit all changes to `feature` and push them `git checkout feature && git push origin feature`
  - Start rebase `git rebase main`
  - Resolve any conflicts (probably in `build.log`) and do `git rebase --continue` till everything is sorted out
  - Then push the rebase to github `git push origin niri --force`