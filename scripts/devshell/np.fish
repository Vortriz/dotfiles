#!/usr/bin/env fish

nix store prefetch-file --json $argv[1] | jq -r .hash