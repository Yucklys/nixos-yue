{ config, pkgs, ... }:

{
  # Nushell for alternative user shell
  programs.nushell = {
    enable = true;

    environmentVariables = {
      THEME = "dark";
      NH_FLAKE = "${config.home.homeDirectory}/nixos-config";
    };

    extraConfig = (builtins.readFile ./config.nu);
    extraEnv = (builtins.readFile ./env.nu)
      + (if pkgs.stdenv.isDarwin then builtins.readFile ./env-darwin.nu else "");

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
  programs.carapace.enableNushellIntegration = false;
  # Disable temporary due to Nushell 0.92.0 compatibility issue
  programs.atuin.enableNushellIntegration = true;

  # Use nushell default ls command
  programs.eza.enable = false;

  # Enable stylix
  stylix.targets.nushell.enable = true;

  # Copy import-my-brew-env.nu to nushell scripts dir on macOS
  home.file = pkgs.lib.mkIf pkgs.stdenv.isDarwin {
    "Library/Application Support/nushell/scripts/import-my-brew-env.nu".source = ./import-my-brew-env.nu;
  };
}
