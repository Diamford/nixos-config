{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix") # Если ставите на VPS/KVM. Для bare-metal уберите.
  ];

  # Базовая загрузка. disko сам добавит нужные grub/systemd-boot настройки,
  # но ядру нужны стандартные модули для инициализации дисков.
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # ВАЖНО: Разделы fileSystems здесь НЕ НУЖНЫ. 
  # Их сгенерирует disko.
}
