{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./nushell
    ./zellij.nix
    ./foot.nix
    ./ghostty.nix
    # ./wezterm
  ];

  # TUI file explorer
  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        pdf = [
          { run = ''zathura "$@"''; desc = "Open with zathura"; block = true; }
        ];
        text = [
	        { run = ''emacsclient -c "$@"''; desc = "Edit with emacs"; block = true; }
	        { run = ''helix "$@"''; desc = "Edit with helix"; block = true; }
        ];
      };
      open.rules = [
        { mime = "text/*"; use = "text"; }
        { name = "*.pdf"; use = "pdf"; }
      ];
    };
  };

  # Shell configuration
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };

  # Zoxide auto jump
  programs.zoxide.enable = true;

  # Alternative to cat
  programs.bat.enable = true;

  # Better command history
  programs.atuin.enable = true;

  # Shell complete
  programs.carapace.enable = true;

  # ls alternative
  programs.eza = lib.mkDefault {
    enable = true;
    icons = true;
  };

  # nix-direnv with nushell support
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
