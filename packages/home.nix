{
  pkgs,
  pkgs-unstable,
  ...
}:

{
  # User packages
  home.packages = with pkgs; [
    # utils
    btop # system monitor
    yt-dlp # youtube-dl fork
    ffmpeg # video processing
    wl-clipboard # copy & paste utilities
    cliphist # clipboard history manager
    satty # screenshot annotation tool
    pkgs-unstable.aider-chat # AI pair programming in your terminal

    # apps
    goldendict-ng # dictionary
    pavucontrol # audio control
    rustdesk # remote desktop
    via # keyboard configurator
    zoom-us # video conferencing
    rofi-rbw-wayland # rofi frontend for rbw
    nautilus # GUI file manager
    teams-for-linux # Microsoft Teams
    hunspell # spell checker
    hunspellDicts.en_US # English dictionary
    bruno # API testing tool

    # messaging
    discord # chat client
    telegram-desktop # chat client
    wechat

    # file extension
    file-roller # archive manager
    mpv # video player
    oculante # image viewer
    localsend # file sharing

    # frontends
    wofi-pass # wofi frontend for pass

    # cli tools
    claude-code
  ];
}
