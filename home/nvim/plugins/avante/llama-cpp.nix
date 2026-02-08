{
  config,
  pkgs,
  lib,
  ...
}: {
  # Install required packages
  environment.systemPackages = with pkgs; [
    # LLM inference server
    llama-cpp

    # Neovim with plugins
    (pkgs.neovim.override {
      configure = {
        customRC = ''
          lua << EOF
          ${builtins.readFile ./nvim-config.lua}
          EOF
        '';
        packages.myVimPackage = with pkgs.vimPlugins; {
          start = [
            # Avante.nvim and dependencies
            avante-nvim
            plenary-nvim
            nui-nvim
            nvim-web-devicons

            # Optional but recommended
            telescope-nvim
            dressing-nvim
            render-markdown-nvim
          ];
        };
      };
    })
  ];

  # Create systemd service for llama.cpp server
  systemd.user.services.qwen-coder = {
    description = "Qwen2.5-Coder 7B LLM Server";
    wantedBy = ["default.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.llama-cpp}/bin/llama-server \
          --model ${pkgs.fetchurl {
          url = "https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF/resolve/main/qwen2.5-coder-7b-instruct-q4_k_m.gguf";
          hash = "sha256-REPLACEME"; # Run nix-prefetch-url to get this
        }} \
          --host 127.0.0.1 \
          --port 8080 \
          --ctx-size 4096 \
          --n-gpu-layers 35
      '';
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
