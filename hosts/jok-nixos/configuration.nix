{ config, lib, pkgs, myOptions, inputs, hostname,... }:
let
  primaryUser = myOptions.users.primaryUser;
  # inherit hostname;
in
{

  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  
  imports = [
    # systemd bootloader
    ../../modules/nixos/bootloader/default.nix
    
    # Common programs + Steam
    ../../modules/nixos/programs/common.nix
    ../../modules/nixos/programs/common-desktop.nix
    ../../modules/nixos/programs/gaming/default.nix
    ../../modules/nixos/programs/ai.nix
    
    # Desktop common configs
    # ../../modules/nixos/desktops/gnome.nix
    ../../modules/nixos/desktops/niri.nix
    ../../modules/nixos/common/desktop.nix
    
    # NVIDIA GPU module (for Turing gpus or newer)
    ../../modules/nixos/nvidia/turing.nix
    ../../modules/nixos/nvidia/cuda.nix
    
    # Random util modules
    ../../modules/nixos/usbmuxd.nix # iOS usb
    ../../modules/nixos/flatpak.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/locale/default.nix # English language + Lithuanian locale
    ../../modules/nixos/virtualisation.nix
    ../../modules/nixos/fonts/common.nix
    ../../modules/nixos/pipewire.nix

    # Auto gc
    ../../modules/nixos/autogc.nix
  ];
  
  networking.hostName = hostname;
  # HOW TO CORRECTLY (imo) ENTER HOSTNAMES IN OTHER MODULES:
  # { config, ...}:
  # let
  #   hostname = config.networking.hostname
  # in
  # { ... }

  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.${primaryUser} = {
    isNormalUser = true;
    description = "Jokubas";
    extraGroups = [ "wheel" "libvirtd" "kvm" ];
  };
  
  system.stateVersion = "26.05";
}
