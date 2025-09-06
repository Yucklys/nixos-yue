{
  pkgs-unstable,
  ...
}:

{
  services.ollama = {
    enable = true;
    package = pkgs-unstable.ollama;
    loadModels = [
      "deepseek-r1:14b"
    ];
    acceleration = "cuda";
  };

  services.open-webui.enable = true;
}
