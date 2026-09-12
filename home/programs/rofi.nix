{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    # font = "sans 12";
    theme = "gruvbox-dark";
  };
}
