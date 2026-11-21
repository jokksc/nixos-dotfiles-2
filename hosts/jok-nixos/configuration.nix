{ inputs, config, lib, pkgs, primaryUser, hostname,... }:
{
  # Modules
  # ---

  # System Modules
  imports = [
    # Desktop
    ../../modules/setups/desktops/gnome.nix

    # Software
    ./software.nix
    ../../modules/nixos/usbmuxd.nix # iOS usb
    ../../modules/nixos/fonts-default.nix
    ../../modules/nixos/docker.nix
    # ../../modules/nixos/waydroid.nix
    # ../../modules/nixos/llama-cpp.nix

    # Features
    # ../../modules/setups/services/jellyfin.nix
    ../../modules/nixos/locale.nix # English language + Lithuanian locale
    ../../modules/nixos/appimage-compat.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/autogc.nix
    inputs.bootvine.nixosModules.default
  ];

  # Home Modules

  home-manager.sharedModules = [(
    { config, pkgs, inputs, primaryUser, ...}:
    {
      imports = [
        inputs.sops-nix.homeModules.sops
        ../../modules/home/zsh.nix
        ../../modules/home/bash.nix
        ../../modules/home/shell-aliases.nix
        ../../modules/home/vscode.nix
      ];
    }
  )];

  # Graphics
  # ---

  # This is for turing graphic cards

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement = {
      enable = true;
      finegrained = false; #claude said to set this to true if its a hybrid laptop gpu
    };
  };

  # Extra System Options
  # ---

  services.bootvine.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [ "i2c-dev" ];
  hardware.i2c.enable = true; 

  programs.zsh.enable = true;
  # i should turn this into a proper nix module

  users.users.${primaryUser} = {
    extraGroups = [ "i2c" "networkmanager" "video" "audio" "input" "libvirtd" "kvm" "wheel" ];
    isNormalUser = true;
    description = "Jokubas";
    # system-wide login shell (tty/ssh login, terminals spawning $SHELL)
    shell = pkgs.zsh;
  };

  virtualisation.docker.enableOnBoot = false;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  
  nix.settings.extra-substituters = [
    "https://niri.cachix.org"
    "https://noctalia.cachix.org"
    "https://cache.nixos-cuda.org"
  ];
  nix.settings.extra-trusted-public-keys = [
    "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}
