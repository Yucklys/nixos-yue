{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;

    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      tuttieee.emacs-mcx
      arcticicestudio.nord-visual-studio-code
      github.copilot
    ];

    userSettings = lib.mkForce {
      "terminal" = {
        "integrated" = {
          "fontFamily" = "'Maple Mono SC NF'";
        };
      };
      "workbench" = {
        "colorTheme" = "Nord";
      };
      "editor.fontFamily" = "'Maple Mono SC NF', 'Fira Code'";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 15;
      "workbench.colorTheme" = "Nord";
      "dafny.verificationTimeLimit" = 60;
    };
  };

  # To work under Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # stylix profile
  # stylix.targets.vscode.profileNames = ["default"];
}
