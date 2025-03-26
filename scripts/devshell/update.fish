#!/usr/bin/env fish

echo "Updating flake and git fetcher inputs..."
cd $FLAKE
nix flake update && fd -e nix --exec update-nix-fetchgit
git add -A
git commit -m "chore: update inputs"
cd -