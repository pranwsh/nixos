{ pkgs, ... }:
{
  home.packages = [
    (pkgs.chromium.override {
      commandLineArgs = [
        "--enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks"
        "--disable-features=UseSkiaRenderer"
        "--ignore-gpu-blocklist"
      ];
    })
  ];
}
