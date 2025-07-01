{inputs, ...}: {
    imports = [
        inputs.nixos-hardware.nixosModules.common-cpu-intel
    ];

    hardware.intelgpu.driver = "xe";

    boot.extraModprobeConfig = ''
        options xe force_probe=9a60
        options i915 force_probe=!9a60
    '';
}
