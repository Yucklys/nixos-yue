{ ... }:

{  
  home.file.hypridle = {
    enable = true;
    target = ".config/hypr/hypridle.conf";
    text = ''
general {
    lock_cmd = loginctl lock-session
    unlock_cmd = loginctl unlock-session
    before_sleep_cmd = systemctl hybrid-sleep
    after_sleep_cmd = notify-send "Awake!"
    ignore_dbus_inhibit = false
}

listener {
    timeout = 500
    on-timeout = notify-send "You are idle!"
    on-resume = notify-send "Welcome back!"
}
'';
  };
}
