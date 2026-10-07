{ config, pkgs, lib, ... }:

{
  imports = [
	./wm/sway.nix
	./shell/zsh.nix
	./programs/nixvim.nix
	./programs/packages.nix
	./programs/reaper.nix
	./programs/netbird.nix
  ];
  # Укажите имя пользователя и домашний каталог
  home.username = "vergil";
  home.homeDirectory = "/home/vergil";

  home.stateVersion = "26.05";

   # Включаем службы, которые должны работать в фоне
  services.gnome-keyring.enable = true; # Для сохранения паролей Wi-Fi и других секретов

  programs.waybar = {
    enable = true;
  };

  programs.fuzzel = {
    enable = true;
  };

  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        shell = "${pkgs.zsh}/bin/zsh";
	font = "NotoMono Nerd Font:size=8";
	dpi-aware = "yes";
      };
    };
  };

    # Автоматическое добавление изменений конфигурации в Git после каждой сборки
  
}
