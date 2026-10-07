{ config, pkgs, lib, ... }:

{
   wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;

    checkConfig = false;

    extraConfig = ''
      corner_radius 5
      smart_corner_radius on

      default_border normal

      gaps inner 3
      gaps outer 5

      default_dim_inactive 0.1

      shadows on
      shadows_on_csd off
      shadow_blur_radius 5
      shadow_color #0000007F

      '';


    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
      menu = "fuzzel";

      input = {
        "*" = {
	  xkb_layout = "us,ru";
	  xkb_options = "grp:alt_shift_toggle";
	};
      };

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in pkgs.lib.mkOptionDefault {
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
      };

      output = {
        "*" = {
	  bg = "/etc/nixos/desktop-configs/desktop/home-manager-config/wm/wallpaper.jpg fill";
	};
      };

      window.border = 0;   
    };
  };

  services.autotiling.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
