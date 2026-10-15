{ config, pkgs, ... }:

{
  # Автоматически создаем папку на хосте при сборке системы
  systemd.tmpfiles.rules = [
    "d /var/lib/adguardvpn 0700 root root - -"
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      adguard-vpn = {
        image = "adguard/adguardvpn-cli:latest";
        autoStart = true;
        
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

