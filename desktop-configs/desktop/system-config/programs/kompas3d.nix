{ pkgs, ... }:

let
	containerName = "kompas3d";
	containerImage = "docker.io/library/alt:p11";

	kompasInstall = pkgs.writeShellApplication {
		name = "kompas3d-install";

		runtimeInputs = with pkgs; [
			distrobox
			podman
		];

		text = ''
			if podman container exists "${containerName}"; then
				echo "Контейнер ${containerName} уже существует."
				exit 0
			fi

			distrobox create \
				--name "${containerName}" \
				--image "${containerImage}" \
				--yes
			kompas3d-enter sudo apt-get install -y wget
			kompas3d-enter sudo apt-get install -y "libxcb-icccm.so.4" "libxcb-image.so.0" "libxcb-keysyms.so.1" "libxcb-render-util.so.0" "libxcb-ewmh.so.2"

			kompas3d-enter sudo bash -c "\$(wget -O - https://repo.ascon.ru/personal/scripts/ascon-personal-alt.sh)"
			kompas3d-enter sudo bash -c "\$(wget -O - https://repo.ascon.ru/scripts/ascon-stable-alt.sh)"
			kompas3d-enter sudo apt-get update
			kompas3d-enter sudo apt-get install -y ascon-kompas3d-study-v25-full ascon-common-coredump-watcher
			kompas3d-enter distroox-export --app kompas-study-v25
		'';
	};

	kompasEnter = pkgs.writeShellApplication {
		name = "kompas3d-enter";

		runtimeInputs = [ pkgs.distrobox ];

		text = ''
			exec distrobox enter "${containerName}" -T -- "$@"
		'';
	};

	kompasRemove = pkgs.writeShellApplication {
		name = "kompas3d-remove";

		runtimeInputs = [ pkgs.distrobox ];

		text = ''
			distrobox rm "${containerName}"
		'';
	};

in
{
	virtualisation.podman = {
		enable = true;
	};

	environment.systemPackages = [
		pkgs.distrobox
		kompasInstall
		kompasEnter
		kompasRemove
	];
}
