{ pkgs, ... }:

{
	home.packages = with pkgs; [
	  swaynotificationcenter
	  driftwm
	];

	xdg.configFile."driftwm/config.toml".source =
		(pkgs.formats.toml {}).generate "driftwm-config.toml" {

			mod_key = "super";
			window_placement = "cursor";
			focus_follows_mouse = true;

			autostart = [
				"waybar"
			];

			input.keyboard = {
				layout = "us,ru";
				options = "grp:alt_shift_toggle";
			};

			decorations = {
				corner_radius = 12;
				shadow = true;
				border_width = 2;
				border_color = "#313244";
				border_color_focused = "#89b4fa";
				opacity = 0.95;
				opacity_focused = 1.0;
			};

			effects = {
				blur_radius = 2;
				blur_strength = 1.1;
				animation_speed = 0.5;
				animation_scale = 0.95;
			};

			background = {
				type = "default";
			};

			window_rules = [
				{
					app_id = "foot";
					opacity = 0.90;
					blur = true;
				}
			];
		};
}
