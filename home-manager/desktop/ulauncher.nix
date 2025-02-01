{
    pkgs,
    inputs,
    ...
}: {
    home.packages = [
        inputs.ulauncher.packages."${pkgs.system}".default
    ];
}