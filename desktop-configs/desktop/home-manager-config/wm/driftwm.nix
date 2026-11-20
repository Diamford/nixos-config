{ pkgs, ... }: {
  wayland.windowManager.driftwm = {
    enable = true;
    # Настройки транслируются в ~/.config/driftwm/config.toml
    settings = {
      autostart = [ "waybar" ];
      window_placement = "auto";
      outer_gap = 12.0;
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        # Резервирует место на экране, чтобы окна не залезали под панель
        exclusive = true;
        modules-left = [ "wlr/taskbar" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "battery" "tray" ];

        "wlr/taskbar" = {
          format = "{icon} {title:.20}";
          icon-size = 18;
          on-click = "activate";
          on-click-middle = "close";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 13px;
      }
      window#waybar {
        background: rgba(30, 30, 46, 0.85);
        color: #cdd6f4;
        border-radius: 10px;
      }
    '';
  };
}

