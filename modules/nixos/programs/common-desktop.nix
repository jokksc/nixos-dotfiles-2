{ lib, config, pkgs, inputs, myOptions, ...}:
let
  primaryUser = myOptions.users.primaryUser;
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.firefox.enable = true;
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
  
  # ddcutil - brightness controls for monitors
  boot.kernelModules = [ "i2c-dev" ];
  hardware.i2c.enable = true; 
  users.users.${primaryUser} = {
    extraGroups = [ "i2c" "networkmanager" "video" "audio" "input" "libvirtd" "kvm" "wheel" ];
    isNormalUser = true;
    description = "Jokubas";
  };
  
  services.xserver = {
    enable = true;
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    vscode
    # vscodium
    kdePackages.filelight
    # pinta
    # rnote
    ptyxis
    pika-backup
    mission-center
    resources
    blackbox-terminal
    python314
    ddcutil
    vicinae
    cbonsai
    # inputs.helix.packages."${pkgs.stdenv.hostPlatform.system}".helix
  ];
}