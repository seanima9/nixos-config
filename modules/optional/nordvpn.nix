{ ... }:
{
  services.nordvpn.enable = true;
  networking.firewall.checkReversePath = "loose";
  users.users.seanimani.extraGroups = [ "nordvpn" ];
  allowedUnfree = [ "nordvpn" ];
}
