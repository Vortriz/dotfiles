# notes to self

## feature branch

- Steps to keep feature branch in parity with main branch
    - Commit all the changes `main` and push them `git checkout main && git push origin main`
    - Commit all changes to `feature` and push them `git checkout feature && git push origin feature`
    - Start rebase `git rebase main`
    - Resolve any conflicts (probably in `build.log`) and do `git rebase --continue` till everything is sorted out
    - Then push the rebase to github `git push origin niri --force`

## steam issues

- Run under `xwayland-satellite`
- Fix black screen with: https://github.com/YaLTeR/niri/wiki/Application-Issues#steam

## AVX2 support

- override AVX2 flag for https://github.com/search?q=repo%3ANixOS%2Fnixpkgs+avx2Support&type=code&p=1
