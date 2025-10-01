{ config, pkgs, inputs, ... }:

{
  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [
      "com.github.tchx84.Flatseal"
      "org.vinegarhq.Sober"
    ];

    overrides = {
      global = {
        Context = {
          share = [ "network" "ipc" ];
          sockets = [ "wayland" "x11" "pulseaudio" ];
          filesystems = [
            "xdg-download:rw"
            "xdg-documents:rw"
          ];
        };
      };
    };
  };
}
