{ config, pkgs, ... }:

{
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      adguard-vpn = {
        image = "adguard/adguardvpn-cli:latest";
        autoStart = true;
        
        # Исправленный синтаксис для линукс-капабилити в NixOS
        capabilities = {
          NET_ADMIN = true;
        };

        extraOptions = [ 
          "--device=/dev/net/tun:/dev/net/tun" 
          "--network=host" 
        ];

        volumes = [
          "/var/lib/adguardvpn:/root/.adguardvpn"
        ];
      };
    };
  };
}

