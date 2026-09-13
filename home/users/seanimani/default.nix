{ osConfig, ... }:
{
  imports = [
    ../../programs/shell.nix
    ../../programs/cli.nix
    ../../programs/git.nix
    ../../programs/neovim.nix
    ./${osConfig.networking.hostName}.nix
  ];

  home = {
    username = "seanimani";
    homeDirectory = "/home/seanimani";
    stateVersion = "26.05";
  };

  programs.git.settings.user = {
    name = "Sean Imani";
    email = "seanimani@proton.me";
  };

  programs.fish.shellAbbrs = {
    nrs = "sudo nixos-rebuild switch --flake /home/seanimani/nixos-config";
  };
}
