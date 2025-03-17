{ config, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    loadModels = [
      "deepseek-r1:7b"
    ];
    acceleration = "cuda";
  };

  services.open-webui.enable = true;
}
