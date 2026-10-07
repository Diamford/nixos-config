{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    git
    firefox
    fastfetch
    steam
    krita
    prismlauncher
    libreoffice
    zip

    python3
    
    nerd-fonts.noto
    noto-fonts

    swaybg
    brightnessctl
    networkmanagerapplet

    platformio-chrootenv

    distrobox
  ];

  fonts.fontconfig.enable = true;
}
