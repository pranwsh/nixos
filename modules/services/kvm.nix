{pkgs, config, ...}: {
  virtualisation.libvirtd.enable = true;
  users.users."${config.my.user.name}".extraGroups = ["libvirtd" "kvm"];
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
}
