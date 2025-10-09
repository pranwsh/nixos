{ config, pkgs, ... }:
{
  # Enable KVM virtualization
  virtualisation.libvirtd.enable = true;
  
  # Add your user to the libvirtd and kvm groups
  users.users.pranesh.extraGroups = [ "libvirtd" "kvm" ];
  
  # Optional but recommended: enable dnsmasq for VM networking
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
}
