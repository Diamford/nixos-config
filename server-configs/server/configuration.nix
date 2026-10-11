# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = []

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;

    settings = {
      PasswordAutentification = true;
      PermitRootLogin = "1234"; # При использовании замените на более сложный.
    };
  };

  system.stateVersion = "26.05"; # Did you read the comment?

}

