{ config, pkgs, ... }:

let
  dataDir = "${config.xdg.configHome}/mpd";
  homeDir = config.home.homeDirectory;
in
{
  home.packages = with pkgs; [
    mpc-cli
    playerctl
    spotify
  ];

  # Start MPD service
  services.mpd = {
    enable = true;

    dataDir = dataDir;
    dbFile = "${dataDir}/database";
    musicDirectory = "${homeDir}/Music";
    playlistDirectory = "${dataDir}/playlists";

    extraConfig =
      ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
      '';
  };

  # Connect MPD to MPRIS
  services.mpd-mpris = {
    enable = true;

    mpd = {
      host = "127.0.0.1";
      port = "6600";
      useLocal = true;
    };
  };

  # TUI client
  programs.ncmpcpp = {
    enable = true;
  };

  programs.ncspot = {
    enable = true;
    settings = {
      use_nerdfont = true;
      notify = true;
      volnorm = true;
    };
  };

  # Spotify daemon
  services.spotifyd = {
    enable = false;
    settings = {
      global = {
        # username = "yucklys687@gmail.com";
        # password_cmd = "${pkgs.pass}/bin/pass Spotify | head -n 1";
        cache_path = "${config.home.homeDirectory}/.cache/spotifyd";
        zeroconf_port = 5354;
        use_mpris = true;
        dbus_type = "session";
        device_name = "nix";
        device_type = "computer";        
      };
    };
  };
}
