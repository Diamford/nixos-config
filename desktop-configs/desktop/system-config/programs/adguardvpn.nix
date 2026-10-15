{ config, pkgs, ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      adguard-vpn = {
        image = "adguard/adguardvpn-cli:latest";
        # Строку containerName мы убрали, имя "adguard-vpn" присвоится автоматически
        autoStart = true;
        
        capabilities = [ "NET_ADMIN" ];
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

