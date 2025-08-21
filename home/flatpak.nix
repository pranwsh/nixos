{ config, pkgs, ... }:

{
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    
    packages = [
      "org.vinegarhq.Sober"
      # Add other packages here
    ];
  };
}
