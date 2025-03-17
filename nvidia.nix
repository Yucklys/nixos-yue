{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lshw
    glxinfo
  ];
  
  # Tell Xorg to use the nvidia driver (also valid for Wayland)
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is needed for most Wayland compositors
    modesetting.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = false;

    # Enable the nvidia settings menu
    nvidiaSettings = true;
  };

  hardware.nvidia.prime = {
    # sync.enable = true;
    offload = {
			enable = true;
			enableOffloadCmd = true;
		};

    # Set by nixos-hardware
    # intelBusId = "PCI:0:2:0";
    # nvidiaBusId = "PCI:1:0:0";
  };
}
