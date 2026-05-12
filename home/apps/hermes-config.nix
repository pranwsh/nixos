{ config, ... }:
{
  home.file.".hermes/config.yaml".text = ''
    model:
      default: meta/llama-3.3-70b-instruct
      base_url: https://integrate.api.nvidia.com/v1
    
    # Optional: ensure it uses the environment variables we set in fish
    provider: nvidia
  '';
}
