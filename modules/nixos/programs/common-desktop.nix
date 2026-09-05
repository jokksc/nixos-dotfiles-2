{ lib, config, pkgs, inputs, ...}:
  
{
  programs.firefox.enable = true;
  programs.localsend = {
    enable = true;
    openFirewall = true;
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
    # inputs.helix.packages."${pkgs.stdenv.hostPlatform.system}".helix
  ];
}