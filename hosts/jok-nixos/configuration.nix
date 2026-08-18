{ config, lib, pkgs, myOptions, inputs, hostname,... }:
let
  primaryUser = myOptions.users.primaryUser;
  # inherit hostname;
in
{

  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  
  imports = [
    # English language + Lithuanian locale
    ../../modules/nixos/locale/default.nix
    
    # Desktop common configs
    ../../modules/nixos/common/desktop.nix
    
    # NVIDIA GPU module (for Turing gpus or newer)
    ../../modules/nixos/nvidia/turing.nix
    
    # Random util modules
    ../../modules/nixos/usbmuxd.nix # iOS usb
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
  
  networking.networkmanager.enable = true;

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelModules = [ "vboxvideo" ];
  
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.${primaryUser} = {
    isNormalUser = true;
    description = "Jokubas";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget 
    fresh-editor 
    alacritty 
    neovim 
    btop 
    # gedit
    # xwallpaper 
    vscode 
    pcmanfm 
    rofi 
    git 
    pfetch
    distrobox
    podman
    bazaar
    vscodium
    kdePackages.filelight
    pinta
    rnote
    ptyxis
    ddcutil
    pika-backup
    # smile
    # usbmuxd # app for usb connection with ios?
    # using services.usbmuxd.enable instead
#  ] ++ [
#    inputs.iloader.packages.${pkgs.system}.default  
  ];

  
  services = {
    flatpak.enable = true;
    # usbmuxd.enable = true; # ios usb thing
    tailscale = {
      enable = true;
      extraSetFlags = [
        "--operator=${primaryUser}"  
      ];
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    fira-code
    nerd-fonts.fira-code
    twemoji-color-font
  ];
  
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

  services.openssh.enable = true;

  virtualisation.podman.enable = true;
    
  # virtualisation.virtualbox.guest.enable = true;
  system.stateVersion = "26.05";
}
