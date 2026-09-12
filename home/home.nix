{ pkgs, ... }:
{
  imports = [
    ./programs/packages.nix
    ./programs/ghostty.nix
    ./programs/vscode.nix
    ./programs/neovim.nix
    ./programs/polkit.nix
    ./programs/hyprland.nix
    ./programs/rofi.nix
  ];

  home = {
    username = "seanimani";
    homeDirectory = "/home/seanimani";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
