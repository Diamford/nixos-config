{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
  	enable = true;
	defaultEditor = true;

	extraPlugins = [
          (pkgs.vimUtils.buildVimPlugin {
            name = "platformio-nvim";
            src = pkgs.fetchFromGitHub {
              owner = "sbatin"; # Используем правильного автора
              repo = "platformio.nvim";
              rev = "master"; 
              # Мы временно пишем пустой sha256. При сборке Nix сам скажет правильный хэш.
              hash = "sha256-PXsuhYmI3uLwjFZgSlliya2YlMWPRHTHKiUGSOJ6/ig=";  
	    };
          })
        ];

	opts = {
	  number = true;
	  relativenumber = true;
	  shiftwidth = 2;
	};

	plugins = {
	  lualine.enable = true;
	  telescope.enable = true;
	  lsp = {
	    enable = true;
	    servers = {
	      clangd.enable = true;
	    };
	  };
	};

	extraConfigLua = ''
	  require('platformio').setup({
	    pio_command = "pio",
	  })
	'';
  };


}
