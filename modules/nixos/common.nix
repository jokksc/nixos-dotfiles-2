{ config, lib, pkgs, primaryUser, inputs,... }:
{
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  
  imports = [
    ./locale/default.nix
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "jok-nixos";
  networking.networkmanager.enable = true;

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelModules = [ "vboxvideo" ];
  
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  
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
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.${primaryUser} = {
    isNormalUser = true;
    description = "Jokubas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
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
    # usbmuxd # app for usb connection with ios?
    # using services.usbmuxd.enable instead
#  ] ++ [
#    inputs.iloader.packages.${pkgs.system}.default  
  ];

  
  services = {
    flatpak.enable = true;
    usbmuxd.enable = true; # ios usb thing
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
