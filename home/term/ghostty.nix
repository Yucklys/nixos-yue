{
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = {
      font-family = "Maple Mono SC NF";
      font-size = 14;
      window-decoration = "auto";
      macos-option-as-alt = true;
      command = "${pkgs.tmux}/bin/tmux new-session -A -s main";
    };
  };
}
