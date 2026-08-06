{ config, lib, pkgs, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      (import "${home-manager}/nixos")
    ];

#  home-manager.useUserPackages = true;
#  home-manager.useGlobalPkgs = true;
#  home-manager.backupFileExtension = "backup"; # This turns duplicate undeclared files to backup files, instead of replacing them
#  home-manager.users.jokub = import ./home.nix;
    
  # Use the GRUB 2 boot loader.
  # Replaced it with another bootloader? - use grub when working in vbox
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Use latest kernel.
  # Disable this in vbox
  boot.kernelPackages = pkgs.linuxPackages_latest;
    
  networking.hostName = "jok-nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelModules = [ "vboxvideo" ];

  # Set your time zone.
  time.timeZone = "Europe/Vilnius";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "lt_LT.UTF-8";
    LC_IDENTIFICATION = "lt_LT.UTF-8";
    LC_MEASUREMENT = "lt_LT.UTF-8";
    LC_MONETARY = "lt_LT.UTF-8";
    LC_NAME = "lt_LT.UTF-8";
    LC_NUMERIC = "lt_LT.UTF-8";
    LC_PAPER = "lt_LT.UTF-8";
    LC_TELEPHONE = "lt_LT.UTF-8";
    LC_TIME = "lt_LT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  
  nixpkgs.config.allowUnfree = true;
  
#  services.picom = {
#    enable = true;
#    backend = "glx";
#    fade = true;
#  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."jokub" = {
    isNormalUser = true;
    description = "Jokubas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    fresh-editor
    alacritty
    neovim
    btop
    gedit
    xwallpaper
    vscode
    pcmanfm
    rofi
    git
    pfetch
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    nerd-fonts.fira-code
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  
  # virtualisation.virtualbox.guest.enable = true;
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "26.05"; # Did you read the comment?

}

