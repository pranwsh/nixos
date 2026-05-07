{ pkgs, ... }: {
  home.packages = [
    (pkgs.chromium.override {
      commandLineArgs = [
        "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,Vulkan,DefaultANGLEVulkan,VaapiIgnoreDriverChecks"
        "--disable-features=UseSkiaRenderer"
      ];
    })
  ];
}
