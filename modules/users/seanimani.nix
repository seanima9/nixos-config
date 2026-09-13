{ ... }:
{
  programs.fish.enable = true;

  users.users.seanimani = {
    isNormalUser = true;
    description = "seanimani";
    extraGroups = [ "wheel" ];
  };

  allowedUnfree = [ "grok-build" ];

  home-manager.users.seanimani = import ../../home/users/seanimani;
}
