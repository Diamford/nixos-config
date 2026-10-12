{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    git
    gh
    firefox
    fastfetch
    steam
    krita
    prismlauncher
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
