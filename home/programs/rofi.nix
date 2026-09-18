{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    extraConfig = {
      modi = "drun,run";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      drun-display-format = "{name}";
      drun-match-fields = "name,keywords";
      sort = true;
      sorting-method = "fzf";
    };
  };
}