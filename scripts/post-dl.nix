{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeFishBin "post-dl" { } ''
            set download_dir "/mnt/SECONDARY/downloads"
            set tmp_dir "$download_dir/.tmp"

            set apks apk
            set compressed zip rar 7z tar gz
            set media mp4 mkv avi mov flv
            set music mp3 wav flac ogg

            for filename in (ls $tmp_dir)
                set file_path "$tmp_dir/$filename"
                set extension (string split -r . $filename)[-1]

                set category none
                if contains $extension $apks
                    set category apks
                else if contains $extension $compressed
                    set category compressed
                else if contains $extension $media
                    set category media
                else if contains $extension $music
                    set category music
                end

                if test $category != none
                    echo "Moving $filename to $category"
                    mv $file_path "$download_dir/$category/$filename"
                    ${pkgs.dunst}/bin/dunstify "$filename downloaded"
                end
            end

            if test (count (ls $tmp_dir)) -gt 0
                set_color -o blue; echo -e "\n\nSort misc files!"
                sleep 1
                ${pkgs.kitty}/bin/kitty --detach superfile $tmp_dir
            end
        '')
    ];
}
