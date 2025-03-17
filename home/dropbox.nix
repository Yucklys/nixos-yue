{ pkgs, ... }:

{
  home.packages = with pkgs; [
    maestral
    maestral-gui
  ];

  systemd.user.services.maestral = {
    Unit.Description = "Maestral daemon";
    Install.WantedBy = [ "default.target" ];
    Service = {
      Type = "notify";
      NotifyAccess = "exec";
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
      ExecStop = "${pkgs.maestral}/bin/maestral stop";
      ExecStopPost = ''/usr/bin/env bash -c "if [ ''${SERVICE_RESULT} != success ]; \
then notify-send Maestral 'Daemon failed'; fi"'';
      WatchdogSec = "30s";
    };
  };
}
