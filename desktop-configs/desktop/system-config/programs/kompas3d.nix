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
		'';
	};

	kompasEnter = pkgs.writeShellApplication {
		name = "kompas3d-enter";

		runtimeInputs = [ pkgs.distrobox ];

		text = ''
			exec distrobox enter "${containerName}" -- "$@"
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
