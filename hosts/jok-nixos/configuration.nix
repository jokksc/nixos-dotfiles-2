{ config, lib, pkgs, myOptions, inputs, hostname,... }:
let
  primaryUser = myOptions.users.primaryUser;
  # inherit hostname;
in
{

  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  
  imports = [
    # Common programs
    ../../modules/nixos/programs/common/default.nix
    
    # English language + Lithuanian locale
    ../../modules/nixos/locale/default.nix
    
    # Desktop common configs
    ../../modules/nixos/common/desktop.nix
    
    # NVIDIA GPU module (for Turing gpus or newer)
    ../../modules/nixos/nvidia/turing.nix
    
    # Random util modules
    ../../modules/nixos/usbmuxd.nix # iOS usb
    ../../modules/nixos/flatpak.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/virtualisation.nix
    ../../modules/nixos/fonts/common.nix
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelModules = [ "i2c-dev" ]; # needs for ddcutil to work
  # hardware.i2c.enable = true; 
  
  networking.hostName = hostname;
  # HOW TO CORRECTLY (imo) ENTER HOSTNAMES IN OTHER MODULES:
  # { config, ...}:
  # let
  #   hostname = config.networking.hostname
  # in
  # { ... }
  
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelModules = [ "vboxvideo" ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.${primaryUser} = {
    isNormalUser = true;
    description = "Jokubas";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  services = {
    # flatpak.enable = true;
    # usbmuxd.enable = true; # ios usb thing
    # tailscale = {
    #   enable = true;
    #   extraSetFlags = [
    #     "--operator=${primaryUser}"  
    #   ];
    # };
  };

  # fonts.packages = with pkgs; [
  #   nerd-fonts.jetbrains-mono
  #   jetbrains-mono
  #   fira-code
  #   nerd-fonts.fira-code
  #   twemoji-color-font
  # ];

  
    
  # virtualisation.virtualbox.guest.enable = true;
  system.stateVersion = "26.05";
}
