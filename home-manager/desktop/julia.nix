{
    programs.scientific-fhs = {
        enable = true;
        juliaVersions = [
            {
                version = "1.11.1";
                default = true;
            }
        ];
        enableNVIDIA = false;
    };
}