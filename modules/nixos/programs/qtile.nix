{ pkgs, ... }:
{
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

  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
  };
  
  environment.systemPackages = with pkgs; [
    gedit
    xwallpaper
    rofi
    pcmanfm 
  ];
}