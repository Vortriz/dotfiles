{
    unify.home = {
        lib,
        lib',
        hostConfig,
        pkgs,
        ...
    }: {
        home.packages = [pkgs.surge];

        xdg.configFile."surge/settings.json".text = lib.toJSON {
            general = {
                default_download_dir = hostConfig.dirs.downloads;
                skip_update_check = true;
                clipboard_monitor = false;
                theme = 2; # dark theme

                category_enabled = true;
                categories = [
                    {
                        name = "Videos";
                        description = "MP4s, MKVs, AVIs, and other video files.";
                        pattern = "(?i)\\.(mp4|mkv|avi|mov|wmv|flv|webm|m4v|mpg|mpeg|3gp)$";
                        path = "/mnt/HOUSE/downloads/media";
                    }
                    {
                        name = "Music";
                        description = "MP3s, FLACs, and other audio files.";
                        pattern = "(?i)\\.(mp3|flac|wav|aac|ogg|wma|m4a|opus)$";
                        path = "/mnt/HOUSE/downloads/music";
                    }
                    {
                        name = "Compressed";
                        description = "ZIPs, RARs, and other archive files.";
                        pattern = "(?i)\\.(zip|rar|7z|tar|gz|bz2|xz|zst|tgz|iso)$";
                        path = "/mnt/HOUSE/downloads/archives";
                    }
                    {
                        name = "Images";
                        description = "JPEGs, PNGs, and other image files.";
                        pattern = "(?i)\\.(jpg|jpeg|png|gif|bmp|svg|webp|ico|tiff|psd)$";
                        path = "/mnt/HOUSE/downloads/media";
                    }
                    {
                        name = "APKs";
                        description = "Android application packages.";
                        pattern = "(?i)\\.(apk)$";
                        path = "/mnt/HOUSE/downloads/apks";
                    }
                ];
            };

            network.max_connections_per_host = 16;
        };

        programs.firefox.policies.ExtensionSettings = builtins.listToAttrs [
            (lib'.extension "surge" "surge@surge-downloader.com")
        ];

        wayland.windowManager.niri.settings.spawn-sh-at-startup = [
            ["${lib.getExe pkgs.surge} server"]
        ];
    };
}
