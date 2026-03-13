{
  pkgs-unstable,
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs-unstable.ghostty-bin else pkgs-unstable.ghostty;
    settings = {
      font-family = "Maple Mono SC NF";
      font-size = 14;
      window-decoration = "auto";
      macos-option-as-alt = true;
      split-inherit-working-directory = true;
      tab-inherit-working-directory = true;
      notify-on-command-finish = "unfocused";
      notify-on-command-finish-after = "10s";
      scroll-to-bottom = "output";
      scrollbar = "never";
    };
  };
}
