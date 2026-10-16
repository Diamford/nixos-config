
{ pkgs, ... }:

let
	image = "local/kompas3d-study:v25";

	dockerfile = pkgs.writeText "Dockerfile" ''
		FROM alt:p11

		RUN apt-get update && \
			apt-get install -y \
				wget \
				ca-certificates

		RUN wget -O /tmp/ascon-personal.sh \
			https://repo.ascon.ru/personal/scripts/ascon-personal-alt.sh && \
			bash /tmp/ascon-personal.sh && \
			rm /tmp/ascon-personal.sh

		RUN wget -O /tmp/ascon-stable.sh \
			https://repo.ascon.ru/scripts/ascon-stable-alt.sh && \
			bash /tmp/ascon-stable.sh && \
			rm /tmp/ascon-stable.sh

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

		${pkgs.docker}/bin/docker build \
			--tag ${image} \
			"$tmp"
	'';
in
{
	virtualisation.docker.enable = true;

	hardware.graphics.enable = true;

	environment.systemPackages = [
		build
	];
}

