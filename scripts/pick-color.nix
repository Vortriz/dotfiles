{
    lib,
    pkgs,
    ...
}:
pkgs.writers.writeFishBin "pick-color" {
    makeWrapperArgs = [
        "--prefix"
        "PATH"
        ":"
        "${lib.makeBinPath (with pkgs; [
            niri-unstable
            zenity
            ripgrep
            wl-clipboard
            libnotify
        ])}"
    ];
} ''
    switch $argv
        case rgb
            niri msg pick-color |\
            rg --only-matching 'rgb\(.*\)' |\
            wl-copy --trim-newline
        case hex
            niri msg pick-color |\
            rg --only-matching '#[a-fA-F0-9]{6}' |\
            wl-copy --trim-newline
        case ui
            # Open a GUI with the picked color
            set zenity_color (zenity\
                --color-selection\
                --title 'Color picker'\
                --color (niri msg pick-color | rg --only-matching '#[a-fA-F0-9]{6}'))

            # Empty if user clicked Cancel or closed the window. RBG color otherwise.
            test -z $zenity_color
            or begin
                # Extract the 3 rbg values.
                set rgb_values (echo $zenity_color |\
                    rg --only-matching '\d{1,3},\d{1,3},\d{1,3}' |\
                    string split ',')

                set hex_color '#'
                for value in $rgb_values
                    set -a hex_color (printf "%.2x" $value)
                end

                # Combine the list into a single string.
                set hex_color (string join "" $hex_color)
                echo $hex_color | wl-copy --trim-newline
            end
        case '*'
            notify-send --urgency critical '  Color picker ERROR' "Bad argument '$argv'"
    end

    set --erase zenity_color
    set --erase rgb_values
''
