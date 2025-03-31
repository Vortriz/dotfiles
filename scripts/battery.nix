{pkgs, ...}:
pkgs.writers.writeFishBin "battery" {} ''
  # Get the current battery percentage
  set battery_percentage (cat /sys/class/power_supply/BAT0/capacity)

  # Get the battery status (Charging or Discharging)
  set battery_status (cat /sys/class/power_supply/BAT0/status)

  # Define the battery icons for each 10% segment
  set battery_icons "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹"

  # Define the charging icon
  set charging_icon "󰂄"

  # Calculate the index for the icon array
  set icon_index (math -s0 $battery_percentage / 10 + 1)

  # Get the corresponding icon
  set battery_icon $battery_icons[$icon_index]

  # Check if the battery is charging
  if test "$battery_status" = "Charging"
      set battery_icon "$charging_icon"
  end

  # Output the battery percentage and icon
  echo "$battery_percentage% $battery_icon"
''
