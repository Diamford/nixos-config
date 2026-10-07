{ config, pkgs, ... }:

{
  imports = [];

  services.netbird.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = [ pkgs.distrobox ];

  # Загрузчик
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.dbus.enable = true;
  systemd.services.systemd-machined.enable = true;

  # Сеть
  networking.hostName = "nixos"; # Задайте имя хоста
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "wt0" ];
  };

  programs.xwayland.enable = true;

  # Установите ваш часовой пояс
  time.timeZone = "Europe/Moscow";

  # Настройте локаль
  i18n.defaultLocale = "ru_RU.UTF-8";

  programs.zsh.enable = true;  

  security.polkit.enable = true;
  programs.sway.enable = true;

  # Включаем поддержку Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Автоматическая очистка мусора для экономии места
  # Будут удалены поколения старше 30 дней
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  users.users.vergil = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Vergil";
    extraGroups = [ "networkmanager" "wheel" "docker" ]; # 'wheel' позволяет выполнять команды с sudo
    # home.username и home.homeDirectory не нужны здесь, так как они определяются
    # автоматически через users.users.<username> и home-manager.users.<username>
  };


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


  nixpkgs.config.allowUnfree = true;

  # Версия системы
  system.stateVersion = "26.05";

  services.udev.packages = [ pkgs.platformio-chrootenv ];

  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  fonts.packages = with pkgs; [
  ];

}
