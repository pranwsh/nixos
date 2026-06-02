{ config, lib, pkgs, ... }:
{
  home.file.".hermes/config.yaml".text = ''
    model:
      default: meta/llama-3.3-70b-instruct
      base_url: https://integrate.api.nvidia.com/v1
      provider: nvidia
  '';

  # Create the .env file from secrets at activation time
  home.activation.hermesEnv = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p $HOME/.hermes
    if [ -f /run/secrets/nvidia_key ]; then
      $DRY_RUN_CMD echo "NVIDIA_API_KEY=$(cat /run/secrets/nvidia_key)" > $HOME/.hermes/.env
      $DRY_RUN_CMD echo "OPENAI_API_KEY=$(cat /run/secrets/nvidia_key)" >> $HOME/.hermes/.env
      $DRY_RUN_CMD echo "API_KEY=$(cat /run/secrets/nvidia_key)" >> $HOME/.hermes/.env
    fi
    if [ -f /run/secrets/mistral_key ]; then
      $DRY_RUN_CMD echo "MISTRAL_API_KEY=$(cat /run/secrets/mistral_key)" >> $HOME/.hermes/.env
    fi
    $DRY_RUN_CMD chmod 600 $HOME/.hermes/.env
  '';
}
