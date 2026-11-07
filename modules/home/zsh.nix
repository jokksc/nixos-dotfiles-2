{...}:
  
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # shared aliases come from home.shellAliases (modules/home/shell-aliases.nix);
    # keep only zsh-specific ones here
    shellAliases = {
      
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
      ];
      theme = "robbyrussell";
    };
    # initExtra = ''
    #   export PATH="$HOME/.local/share/pi-node/current/bin:$PATH"
    # '';
      # this only works in Distrobox container, to run Pi harness
  };
}