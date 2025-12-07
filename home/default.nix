{ config, pkgs, inputs, ... }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pynvim
    pip
  ]);

  hyprsnow = pkgs.rustPlatform.buildRustPackage {
    pname = "hyprsnow";
    version = "0.1.0"; # whatever, just for identification

    # Fetch the source (adjust these!)
    src = pkgs.fetchFromGitHub {
      owner = "spinualexandru";      # e.g. "Gerschtli"
      repo  = "hyprsnow";
      rev   = "1468e8e";   # e.g. "v1.0.0" or a commit hash
      hash  = "sha256-uDEukIX2oXNfy2a7ut0HemjFtXlK/t2EIloC5JZUv5Y=";
    };

    # First run: put a dummy hash, let Nix fail, copy the suggested value here
    cargoHash = "sha256-VVSAaE1+/QxMVdYD11jha+eI6jM+ln53SeutdvMDmhU=";

    buildInputs = [
      pkgs.wayland
      pkgs.libxkbcommon
      pkgs.xkeyboard_config
      pkgs.libGL
      pkgs.vulkan-loader
    ];

    nativeBuildInputs = [
      pkgs.pkg-config
      pkgs.makeWrapper
    ];

    postInstall = ''
      wrapProgram $out/bin/hyprsnow \
        --set LD_LIBRARY_PATH ${
          pkgs.lib.makeLibraryPath [
            pkgs.libGL
            pkgs.vulkan-loader
            pkgs.libxkbcommon
            pkgs.wayland
          ]
        } \
        --set-default XKB_CONFIG_ROOT ${pkgs.xkeyboard_config}/share/X11/xkb
   '';
  };
in
{
  imports = [
    ./hyprland
    ./cursor.nix
    ./kitty.nix
    ./bash.nix
    ./zathura.nix
    ./latex.nix
    ./zen/zen.nix
    ./spotify/spotify.nix
    ./nvim/nvim.nix
    ./prismlauncher.nix
    ./flatpak.nix
  ];
  
  home.username = "pranesh";
  home.homeDirectory = "/home/pranesh";
  
  home.packages = [
    pythonEnv
    pkgs.tree-sitter
    pkgs.wineWowPackages.stable
    pkgs.gemini-cli
    pkgs.discord
    pkgs.libreoffice
    pkgs.qemu
    pkgs.chromium
    hyprsnow
  ];
  
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
