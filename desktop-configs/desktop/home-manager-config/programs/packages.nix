{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    git
    codex
    gh
    firefox
    fastfetch
    steam
    krita
    prismlauncher
    omnissa-horizon-client
    zip
    gamescope

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
