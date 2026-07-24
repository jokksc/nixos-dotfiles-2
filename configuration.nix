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
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "jok-nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "vboxvideo" ];

  time.timeZone = "Europe/Vilnius";
  i18n.defaultLocale = "lt_LT.UTF-8";
  i18n.supportedLocales = [ "lt_LT.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ] ;
  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/Downloads/wallhaven-e86mv8.jpg
    '';
  };

  services.displayManager.ly.enable = true;
  
  nixpkgs.config.allowUnfree = true;
  
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
  };

  users.users.jokub = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
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
    fira-code
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  
  virtualisation.virtualbox.guest.enable = true;
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

