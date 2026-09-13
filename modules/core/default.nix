{ inputs, ... }:
{
  imports = [
    ./nix.nix
    ./locale.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    sharedModules = [ inputs.catppuccin.homeModules.catppuccin ];
  };
}
