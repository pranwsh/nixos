{
  config,
  pkgs,
  lib,
  ...
}: let
  qwen-model = pkgs.fetchurl {
    url = "https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF/resolve/main/qwen2.5-coder-7b-instruct-q4_k_m.gguf";
    hash = "sha256-UJKH94y01M9rOENzRzO5FLLBWOQ+Iqf0v16WOACJTTw=";
  };
in {
  home.packages = with pkgs; [
    llama-cpp
  ];

  # Set dummy API key so avante doesn't prompt
  home.sessionVariables = {
    OPENAI_API_KEY = "dummy-key-not-needed";
  };

  systemd.user.services.qwen-coder = {
    Unit = {
      Description = "Qwen2.5-Coder 7B LLM Server";
      After = ["network.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.llama-cpp}/bin/llama-server --model ${qwen-model} --host 127.0.0.1 --port 8080 --ctx-size 4096 --n-gpu-layers 35";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
