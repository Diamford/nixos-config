{ pkgs, config, ... }:

{
  systemd.user.services.init-alt-distrobox = {
    Unit = {
      Description = "Initialize ALT Linux Distrobox and install packages";
      # Убрали After = [ "default.target" ], чтобы не блокировать автозапуск
    };

    Install = {
      WantedBy = [ "default.target" ];
    };    

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      
      ExecStart = pkgs.writeShellScript "init-alt-linux" ''
        set -euo pipefail # Прерывать выполнение при любой ошибке
        
        # Проверяем, существует ли контейнер
        if ! ${pkgs.distrobox}/bin/distrobox list | grep -q "alt-env"; then
          
          # Создаем контейнер
          ${pkgs.distrobox}/bin/distrobox create \
            --name alt-env \
            --image alt:p10 \
            --yes

          # Выполняем установку внутри контейнера
          ${pkgs.distrobox}/bin/distrobox enter alt-env -- bash -c '
            set -euo pipefail
            
            # Используем sudo -n (non-interactive). 
            # Если sudo потребует пароль, скрипт сразу упадет с понятной ошибкой, 
            # а не будет висеть в ожидании ввода с несуществующего терминала.
            sudo -n wget -qO - https://repo.ascon.ru/personal/scripts/ascon-personal-alt.sh | sudo -n bash || true
            sudo -n wget -qO - https://repo.ascon.ru/scripts/ascon-stable-alt.sh | sudo -n bash || true
            
            sudo -n apt-get update
            
            # ВАЖНО: добавлен флаг -y для автоматического подтверждения установки пакетов
            sudo -n apt-get install -y ascon-kompas3d-study-v25-full ascon-common-coredump-watcher
          '
        fi
      '';
    };
  };
}
