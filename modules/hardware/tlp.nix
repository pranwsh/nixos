{ config, pkgs, ... }:
{
  powerManagement.enable = true;

  environment.systemPackages = [ pkgs.acpi ];

  services.logind = {
    settings.Login = {
      LidSwitchIgnoreInhibited = "no";
      HandleLidSwitch = "suspend";
    };
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 70;

      # Don't sacrifice WiFi/latency for battery.
      # RTL8852BE / rtw89 wedges with power-save / ASPM / runtime-PM:
      # symptom = ping 8.8.8.8 instantly fails, only reboot fixes.
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";

      # TLP default puts PCIe wifi into runtime-suspend + ASPM powersave on BAT.
      # That is the classic rtw89_8852be hang. Force off on both AC and BAT.
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "on";
      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "performance";

      # Belt-and-braces: never runtime-suspend the Realtek wifi or its BT USB sibling
      # (8852BE is a wifi+BT combo, BT autosuspend can also wedge wifi).
      RUNTIME_PM_DENYLIST = "01:00.0";
      RUNTIME_PM_DRIVER_DENYLIST = "rtw89_8852be rtw89_pci rtw89_core rtw89_8852b btusb";
      USB_DENYLIST = "0bda:b85c";

      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };
}
