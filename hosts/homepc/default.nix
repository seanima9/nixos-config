{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/optional/boot.nix
    ../../modules/optional/networking.nix
    ../../modules/optional/nvidia.nix
    ../../modules/optional/hyprland.nix
    ../../modules/optional/onepassword.nix
    ../../modules/optional/keyring.nix
    ../../modules/optional/nordvpn.nix
    ../../modules/users/seanimani.nix
  ];

  networking.hostName = "homepc";
  system.stateVersion = "26.05";

  allowedUnfree = [
    "brave-origin"
    "vscode"
  ];
}
