{pkgs, ...}: {
    programs.micro = {
        enable = true;

        package = pkgs.micro-full;
    };

    stylix.targets.micro.enable = true;
}
