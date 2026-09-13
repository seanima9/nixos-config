{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      find = "fd";
      grep = "rg";
    };
  };

  programs.zoxide.enable = true;

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
    fileWidget.command = "fd --type f --hidden --exclude .git";
    changeDirWidget.command = "fd --type d --hidden --exclude .git";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
