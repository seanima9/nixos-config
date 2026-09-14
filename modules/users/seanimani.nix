{ ... }:
{
  programs.fish.enable = true;

  users.users.seanimani = {
    isNormalUser = true;
    description = "seanimani";
    extraGroups = [ "wheel" ];
  };

  allowedUnfree = [ "grok-build" "cursor" "cursor-cli" ];

  home-manager.users.seanimani = import ../../home/users/seanimani;
}
