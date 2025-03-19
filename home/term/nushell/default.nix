{ config, pkgs, ... } :

let
  nuSampleConfig = "https://raw.githubusercontent.com/nushell/nushell/${pkgs.nushell.version}/crates/nu-utils/src/sample_config";
  defaultNuConfig = pkgs.fetchurl {
    url = "${nuSampleConfig}/default_config.nu";
    hash = "sha256-rARy6plX4hFybOow5AIDga02n/nlafT3iLjDeyxMVDQ=";
  };
  defaultNuEnv = pkgs.fetchurl {
    url = "${nuSampleConfig}/default_env.nu";
    hash = "sha256-gjF/wBCHMvZ+T5hQGTjJpmeRsg3PFSYJVryNY9OjSH0=";
  };
in
{
  # Nushell for alternative user shell
  programs.nushell = {
    enable = true;

    configFile.source = "${defaultNuConfig}";
    envFile.source = "${defaultNuEnv}";

    extraConfig = (builtins.readFile ./config.nu);
    extraEnv = (builtins.readFile ./env.nu);

    shellAliases = {
      vim = "nvim";
      ec = "emacsclient -nc";
      magit = "emacsclient -nc -e '(magit)'";
      devenv-init = "nix flake init --template github:cachix/devenv";
    };
  };

  # Enable program integrations
  programs.zoxide.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;
  programs.yazi.enableNushellIntegration = true;
  # Disable temporary due to Nushell 0.92.0 compatibility issue
  programs.atuin.enableNushellIntegration = false;

  # Use nushell default ls command
  programs.eza.enable = false;
}
