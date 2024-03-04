{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { 
    self, 
    nixpkgs, 
    nixpkgs-unstable, 
    home-manager,
    ... 
    }@inputs:
    {
      nixosConfigurations = {
        PC = nixpkgs.lib.nixosSystem {
          modules = [ 
            ./hosts/PC/configuration.nix
          ];
        };
        Laptop = nixpkgs.lib.nixosSystem {
          modules = [ 
            ./hosts/Laptop/configuration.nix
          ];
        };;
      };
    };
}
