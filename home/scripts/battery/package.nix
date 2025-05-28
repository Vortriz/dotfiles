{pkgs, ...}:
pkgs.writers.writeFishBin "battery" {} ''
    set battery_percentage (cat /sys/class/power_supply/BAT0/capacity)
    set battery_status (cat /sys/class/power_supply/BAT0/status)

    # Define the battery icons for each 10% segment
    set battery_icons "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹"
    set charging_icon "󰂄"

    set icon_index (math -s0 $battery_percentage / 10 + 1)
    set battery_icon $battery_icons[$icon_index]

    if test "$battery_status" = "Charging"
        set battery_icon "$charging_icon"
    end

    echo "$battery_percentage% $battery_icon"
''
