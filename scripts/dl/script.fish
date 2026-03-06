#!/usr/bin/env fish
# @vicinae.schemaVersion 1
# @vicinae.title Download File
# @vicinae.mode terminal
# @vicinae.argument1 { "type": "text", "placeholder": "URL" }

dl $argv[1] && notify-send --app-name="dl" "Download Complete" "The file has been downloaded successfully."
