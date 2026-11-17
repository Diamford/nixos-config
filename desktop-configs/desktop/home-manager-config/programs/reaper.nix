{ config, pkgs, reaper-flake, ... }:
let
  reaperPackages = reaper-flake.packages.${pkgs.system};
in
{
	programs.reaper = {
		enable = true;

		theme = {
		  active = "Reapertips Theme.ReaperThemeZip";
		  packages = [
		    reaperPackages.reapertips-theme
		    reaperPackages.smooth6-theme
		    reaperPackages.part-theme
		    reaperPackages.reark-theme
		  ];
		};

		swell.colortheme = {
		  enable = true;
		};

		extensions = {
		  reapack.enable = true;
		  sws = {
		    enable = true;
		  };
		};
		preferences = {
		  general.startupSettings.showSplashScreenOnStartup = false;
		  project.trackSendDefaults.trackVolumeFaderGain = -10.0;
		};
	};

	home.packages = with pkgs; [
	  surge-xt
	  dexed
	  helm
	  
	  lsp-plugins
	  calf
	  dragonfly-reverb
	  chow-tape-model

	  x42-plugins
	  zam-plugins
	  airwindows

	  hydrogen
	  sfizz
	];
}
