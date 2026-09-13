{ osConfig, ... }:
{
  imports = [
    ../../programs/shell.nix
    ../../programs/cli.nix
    ../../programs/git.nix
    ../../programs/neovim.nix
    ./${osConfig.networking.hostName}.nix
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";
    gtk.icon.enable = true;
    vscode.profiles.default.enable = false;
  };

  home = {
    username = "seanimani";
    homeDirectory = "/home/seanimani";
    stateVersion = "26.05";
  };

  programs.git.settings.user = {
    name = "Sean Imani";
    email = "seanimani@proton.me";
  };
}
