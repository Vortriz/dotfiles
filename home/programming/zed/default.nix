{
    imports = [
        ./extensions.nix
        ./keymap.nix
        ./settings.nix
    ];

    programs.zed-editor.enable = true;

    stylix.targets.zed.enable = true;
}
