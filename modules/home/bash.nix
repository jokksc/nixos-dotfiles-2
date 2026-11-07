{...}:
  
{
  programs.bash = {
    enable = true;
    # shared aliases come from home.shellAliases (modules/home/shell-aliases.nix)
    # initExtra = ''
    #   export PATH="$HOME/.local/share/pi-node/current/bin:$PATH"
    # '';
      # this only works in Distrobox container, to run Pi harness
  };
}