{ ... }:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "seanimani" ];
  };
  allowedUnfree = [
    "1password"
    "1password-cli"
  ];
}
