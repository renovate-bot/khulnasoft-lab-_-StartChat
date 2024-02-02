{ pkgs }: {
  deps = [
    pkgs.nvidia-podman
    pkgs.docker-compose_1
    pkgs.docker-compose
  ];
}
