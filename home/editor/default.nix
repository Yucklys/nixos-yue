{
  pkgs-unstable,
  ...
}:

{
  imports = [
    ./emacs.nix
    # ./vscode.nix
    ./zed.nix
    ./helix.nix
  ];

  home.sessionVariables = {
    VISUAL = "emacsclient";
  };

  home.packages = [
    pkgs-unstable.copilot-language-server
  ];
}
