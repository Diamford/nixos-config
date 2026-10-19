{ pkgs, ... }:

let
	image = "local/kompas3d-study:v25";

	dockerfile = pkgs.writeText "Dockerfile" ''
		FROM alt:p11

		# Переключаем зеркала на HTTPS
		RUN sed -i \
			's|http://ftp.altlinux.org|https://ftp.altlinux.org|g' \
			/etc/apt/sources.list || true

		RUN find /etc/apt/sources.list.d \
			-type f -name "*.list" \
			-exec sed -i \
				's|http://ftp.altlinux.org|https://ftp.altlinux.org|g' {} + \
			2>/dev/null || true

		# Обновление и базовые зависимости
		RUN apt-get update && \
			apt-get install -y \
				wget \
				ca-certificates \
				curl \
				gnupg

		# Репозиторий АСКОН Personal
		RUN wget -O /tmp/ascon-personal.sh \
			https://repo.ascon.ru/personal/scripts/ascon-personal-alt.sh && \
			bash /tmp/ascon-personal.sh && \
			rm /tmp/ascon-personal.sh

		# Репозиторий АСКОН Stable
		RUN wget -O /tmp/ascon-stable.sh \
			https://repo.ascon.ru/scripts/ascon-stable-alt.sh && \
			bash /tmp/ascon-stable.sh && \
			rm /tmp/ascon-stable.sh

		# Установка КОМПАС-3D
		RUN apt-get update && \
			apt-get install -y \
				ascon-kompas3d-study-v25-full \
				ascon-common-coredump-watcher
	'';

	build = pkgs.writeShellScriptBin "kompas3d-build" ''
		set -euo pipefail

		tmp="$(${pkgs.coreutils}/bin/mktemp -d)"
		trap 'rm -rf "$tmp"' EXIT

		cp ${dockerfile} "$tmp/Dockerfile"

		${pkgs.podman}/bin/podman build \
			--tag ${image} \
			"$tmp"
	'';
in
{
	hardware.graphics.enable = true;

	environment.systemPackages = [
		build
	];
}
