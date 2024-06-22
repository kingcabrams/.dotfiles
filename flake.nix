{
  description = "Nixos Config";
 
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
 
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };
 
  outputs = { self, nixpkgs, ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
	lib = nixpkgs.lib;
    in
    {
        nixosConfigurations = with lib; {
	    nixos = nixosSystem {
            	specialArgs = {inherit system inputs;};
            	modules = [
                    ./configuration.nix
                    inputs.home-manager.nixosModules.default
                ];
            };
 
        };
    };
}
