#!/usr/bin/env fish
# @vicinae.schemaVersion 1
# @vicinae.title DOI to BibTeX
# @vicinae.mode compact
# @vicinae.icon https://www.doi.org/images/communities/DOI%20Logo%20Icon-RGB.png
# @vicinae.argument1 { "type": "text", "placeholder": "identifier" }

doi2bib3 $argv[1] | wl-copy
echo "BibTeX entry copied to clipboard."
