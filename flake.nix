{
   description = "My NixOS Flake";

   inputs = {
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
     
     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };

   };

   outputs = { self, nixpkgs, home-manager, ... } @ inputs:
     {
       nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
	 modules = [
	   ./configuration.nix
	   home-manager.nixosModules.default
	   {
	     home-manager = {
	       useGlobalPkgs = true;
	       useUserPackages = true;
	       extraSpecialArgs = { inherit inputs; };
	       users.seanimani = ./home/home.nix;
	     };
	   }
         ];
       };
     };
}
