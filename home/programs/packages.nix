{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Sean Imani";
      userEmail = "seanimani@proton.me";
      delta.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    tldr
    tmux
    ripgrep
    fd
    brave-origin
    nordvpn
    gh
    fish
    zoxide
    lazygit
    btop
    procs
    grok-build
    vscode
  ];
}