{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableFishIntegration = true;
    settings = {
      command = "fish";
    };
  };
}
