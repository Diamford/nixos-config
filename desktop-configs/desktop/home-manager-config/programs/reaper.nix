{ config, pkgs, inputs, ... }:
{
	programs.reaper = {
		enable = true;

		extensions = {
		  reapack.enable = true;
		  sws.enable = true;
		};
		preferences = {
		  general.startupSettings.showSplashScreenOnStartup = false;
		};
	};
}
