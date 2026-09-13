{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/optional/boot.nix
    ../../modules/optional/networking.nix
    ../../modules/optional/nvidia.nix
    ../../modules/optional/hyprland.nix
    ../../modules/optional/fcitx5.nix
    ../../modules/optional/onepassword.nix
    ../../modules/optional/keyring.nix
    ../../modules/optional/nordvpn.nix
    ../../modules/optional/bluetooth.nix
    ../../modules/optional/trezor.nix
    ../../modules/users/seanimani.nix
  ];

  networking.hostName = "homepc";
  system.stateVersion = "26.05";

  allowedUnfree = [
    "brave-origin"
    "vscode"
    "trezor-suite"
  ];
}
