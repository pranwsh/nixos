{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  users.users.pranesh.extraGroups = ["libvirtd" "kvm"];
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
}
