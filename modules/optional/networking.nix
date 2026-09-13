{ ... }:
{
  networking.networkmanager.enable = true;
  users.users.seanimani.extraGroups = [ "networkmanager" ];
}
