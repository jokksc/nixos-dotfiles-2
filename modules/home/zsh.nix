{...}:
  
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      btw = "echo i use nixos btw";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles-2#jok-nixos";
      syu = "sudo nix flake update --flake ~/nixos-dotfiles-2 && sudo nixos-rebuild switch --flake ~/nixos-dotfiles-2#jok-nixos";
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