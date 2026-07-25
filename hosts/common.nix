{ config, lib, pkgs, ... }:
{
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  networking.hostName = "jok-nixos";
  networking.networkmanager.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "vboxvideo" ];

  time.timeZone = "Europe/Vilnius";
  i18n.defaultLocale = "lt_LT.UTF-8";
  i18n.supportedLocales = [ "lt_LT.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings.LC_MESSAGES = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.jokub = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ tree ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim wget fresh-editor alacritty neovim btop gedit
    xwallpaper vscode pcmanfm rofi git pfetch
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    fira-code
  ];

  virtualisation.virtualbox.guest.enable = true;
  system.stateVersion = "26.05";
}