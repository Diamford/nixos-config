{ pkgs, ... }:

{
  home.packages = [
    pkgs.netbird-ui
  ];

  wayland.windowManager.sway.config.startup = [{ command = "netbird-ui"; }];
}
