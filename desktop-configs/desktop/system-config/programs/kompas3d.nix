{ pkgs, ... }:

let
	name = "kompas3d";
	image = "docker.io/alt:p11";

	manifest = pkgs.writeText "kompas3d.ini" ''
		[${name}]
		image=${image}
		pull=false
		replace=false
		root=false
		nvidia=true
		init=false
		start_now=false
	'';

	installScript = pkgs.writeShellScript "kompas3d-install" ''
		set -euo pipefail

		# Выполняется внутри ALT Linux
		if rpm -q ascon-kompas3d-study-v25-full >/dev/null 2>&1; then
			echo "КОМПАС-3D уже установлен"
			exit 0
		fi

		apt-get update
		apt-get install -y \
			wget \
			ca-certificates \
			curl \
			gnupg

		wget -O /tmp/ascon-personal.sh \
			https://repo.ascon.ru/personal/scripts/ascon-personal-alt.sh
		bash /tmp/ascon-personal.sh

		wget -O /tmp/ascon-stable.sh \
			https://repo.ascon.ru/scripts/ascon-stable-alt.sh
		bash /tmp/ascon-stable.sh

		apt-get update
		apt-get install -y \
			ascon-kompas3d-study-v25-full \
			ascon-common-coredump-watcher
	'';

	setup = pkgs.writeShellScriptBin "kompas3d-setup" ''
		set -euo pipefail

		export DBX_CONTAINER_MANAGER=podman

		${pkgs.distrobox}/bin/distrobox assemble create \
			--file ${manifest}

		${pkgs.distrobox}/bin/distrobox enter ${name} \
			-- sudo /bin/bash -s < ${installScript}
	'';

	enter = pkgs.writeShellScriptBin "kompas3d-enter" ''
		exec ${pkgs.distrobox}/bin/distrobox enter ${name}
	'';

in
{
	hardware.graphics.enable = true;

	environment.systemPackages = with pkgs; [
		distrobox
		setup
		enter
	];
}
