{
  description = "NixOS configuration with Plasma 6";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    reaper-flake = {
      url = "github:9Prestidigitator/reaper-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, home-manager, nixvim, reaper-flake, ... }@inputs: {
    diskoConfigurations = {
      desktop = import ./disko-config.nix;
    };

    nixosConfigurations = {
      # Замените "nixos" на имя вашего хоста (hostname)
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = {};
        modules = [
	  ./desktop-configs/desktop/system-config/configuration.nix

	home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;

	    home-manager.sharedModules = [  
	      nixvim.homeManagerModules.nixvim
	      reaper-flake.homeModules.reaper
	    ];

	    home-manager.users = {
	      vergil = {
	        imports = [
		  ./desktop-configs/desktop/home-manager-config/home.nix
		];
	      };
	    };
	  }
        ];
      };

      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
      };
	
    };
  };
}
