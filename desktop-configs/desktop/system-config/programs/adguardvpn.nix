{ config, pkgs, ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      adguard-vpn = {
        image = "adguard/adguardvpn-cli:latest"; # Официальный образ AdGuard
        containerName = "adguard-vpn";
        autoStart = true;
        
        capabilities = [ "NET_ADMIN" ];
        extraOptions = [ 
          "--device=/dev/net/tun:/dev/net/tun" 
          "--network=host" # Чтобы пустить трафик ВСЕГО компьютера через VPN
        ];

        volumes = [
          "/var/lib/adguardvpn:/root/.adguardvpn"
        ];
      };
    };
  };
}

