{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { 
    self, 
    nixpkgs, 
    nixpkgs-unstable, 
    home-manager,
    ... 
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable { system = system; config.allowUnfree = true; };
      home-manager = import home-manager;

      mkSystem = modules:
      nixpkgs.lib.nixosSystem {
	      inherit modules;
        specialArgs = { inherit inputs outputs pkgs-unstable; };
      };
    in 
    {
      nixosConfigurations = {
        PC = mkSystem [ ./hosts/PC/configuration.nix inputs.home-manager.nixosModules.default ];
        Laptop = mkSystem [ ./hosts/Laptop/configuration.nix inputs.home-manager.nixosModules.default ];
        Laptop2 = mkSystem [ ./hosts/Laptop2/configuration.nix inputs.home-manager.nixosModules.default ];
      };
			
			devShells.x86_64-linux.default = (import ./modules/shell.nix {inherit pkgs; });
    };
}
