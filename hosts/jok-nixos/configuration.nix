{ config, lib, pkgs, myOptions, inputs, hostname,... }:
let
  primaryUser = myOptions.users.primaryUser;
in
{
  imports = [
    # Common programs + Steam
    ../../modules/nixos/programs/common.nix
    ../../modules/nixos/programs/common-desktop.nix
    ../../modules/nixos/programs/gaming/default.nix
    ../../modules/nixos/programs/ai.nix
    
    # Desktop common configs
    ../../modules/nixos/programs/gnome.nix

    # inputs.noctalia.nixosModules.default
    # ../../modules/nixos/programs/noctalia.nix
    # ../../modules/nixos/programs/stylix.nix
    # ../../modules/nixos/programs/niri.nix
    
    # NVIDIA GPU module (for Turing gpus or newer)
    ../../modules/nixos/nvidia/turing.nix
    ../../modules/nixos/nvidia/cuda.nix
    
    # Random util modules
    ../../modules/nixos/usbmuxd.nix # iOS usb
    ../../modules/nixos/flatpak.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/locale.nix # English language + Lithuanian locale
    ../../modules/nixos/virtualisation.nix
    ../../modules/nixos/fonts/common.nix
    ../../modules/nixos/pipewire.nix
    # ../../modules/nixos/waydroid.nix
    ../../modules/nixos/docker.nix

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
  
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  
  environment.systemPackages = with pkgs; [
    # code-cursor
    # open-webui
    #pi-coding-agent
    uv
    ghostty
    zsh
    uxplay
    # (t3code.override {
    #   t3code-unwrapped = t3code.unwrapped.overrideAttrs (old: {
    #     version = "0.0.45";
    #     src = old.src.override {
    #       tag = "v0.0.45";
    #       hash = "sha256-8drTHjFqa2vJ96jhpRZXmNbtbXtKk1q40jOEp9dohNc=";
    #     };
    #     pnpmDeps = old.pnpmDeps.override {
    #       hash = "sha256-2dGEHOQrnidTei54NlZTJh5u5/i810hb2LddK4XfUNQ=";
    #     };
    #   });
    # })
    t3code
  ];
  
  virtualisation.docker.enableOnBoot = false;

  # users.users.${primaryUser} = {
  #   isNormalUser = true;
  #   description = "Jokubas";
  #   extraGroups = [ "wheel" ];
  # };
  
  system.stateVersion = "26.05";
}
