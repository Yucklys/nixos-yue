{ ... }:

let
  user = "zkli";
in
{
  imports = [
    ../home/term
    ../home/editor
    ../home/wm/aerospace.nix
  ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "25.11";

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/etc/profiles/per-user/${user}/bin"
    "/Users/${user}/.local/bin"
  ];

  home.sessionVariables = {
    FLAKE_PATH = "/Users/${user}/nixos-config";
  };

  programs.home-manager.enable = true;

  programs.nushell = {
    shellAliases = {
      bb = "brazil-build";
      bws = "brazil ws";
      brc = "brazil-recursive-cmd";
    };
    extraConfig = ''
def adac [account_id: string] {
  ada credentials update --account=($account_id) --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --once
}

def aerospace-cleanup [] {
  let all_windows = (aerospace list-windows --all --json)

  let ghost_windows = $all_windows | from json | where window-title == ""
  let ghost_windows_count = $ghost_windows | length
  print $ghost_windows

  $ghost_windows | get window-id | each {|id| aerospace close --window-id $id }
  print $"Successfully cleanup ($ghost_windows_count) ghost windows!"
}

let mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save $mise_path --force

use ($nu.default-config-dir | path join mise.nu)
'';
  };

  # Colorful borders
  services.jankyborders = {
    enable = true;
    settings = {
      style = "round";
      width = 6.0;
      active_color = "0xff00ccff";
      inactive_color = "0xff1a202b";
    };
  };
}
