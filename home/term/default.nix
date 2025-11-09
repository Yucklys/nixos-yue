{
  lib,
  ...
}:

{
  imports = [
    ./nushell
    ./zellij.nix
    ./foot.nix
    # ./ghostty.nix
    # ./wezterm
  ];

  # TUI file explorer
  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        pdf = [
          {
            run = ''zathura "$@"'';
            desc = "Open with zathura";
            block = true;
          }
        ];
        text = [
          {
            run = ''emacsclient -c "$@"'';
            desc = "Edit with emacs";
            block = true;
          }
          {
            run = ''helix "$@"'';
            desc = "Edit with helix";
            block = true;
          }
        ];
      };
      open.rules = [
        {
          mime = "text/*";
          use = "text";
        }
        {
          name = "*.pdf";
          use = "pdf";
        }
      ];
    };
  };
  stylix.targets.yazi.enable = true;

  # Shell configuration
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
  stylix.targets.starship.enable = true;

  # Zoxide auto jump
  programs.zoxide.enable = true;

  # Alternative to cat
  programs.bat.enable = true;
  stylix.targets.bat.enable = true;

  # fuzzy search tool
  programs.fzf.enable = true;
  stylix.targets.fzf.enable = true;

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
