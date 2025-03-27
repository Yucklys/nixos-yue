{ config, pkgs, pkgs-unstable, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs-unstable.ollama;
    loadModels = [
      "deepseek-r1:7b"
      "gemma3:12b"
    ];
    acceleration = "cuda";
  };

  services.open-webui.enable = true;
}
