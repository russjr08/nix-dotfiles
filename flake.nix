{
  description = "Nix configuration for Russ";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      #config = { allowUnfree = true; };
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;

  in {
    nixosConfigurations = {
      charlemagne = lib.nixosSystem {
	specialArgs = { inherit inputs; };

	modules = [
          ({ pkgs, pkgs-unstable, ... }:
            let
              overlay-unstable = final: prev: {
                unstable = import nixpkgs-unstable {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
              };
            in
              {
                nixpkgs.overlays = [ overlay-unstable ];
                environment.systemPackages = with pkgs; [
                  unstable.jetbrains-toolbox
                  unstable.hubstaff
                ];
              }
          )
	  ./hosts/charlemagne/configuration.nix
	];

      };

    };

    homeConfigurations = {
      russjr08 = home-manager.lib.homeManagerConfiguration {
	pkgs = nixpkgs.legacyPackages.${system};
	modules = [
	  ./home-manager/home.nix
	];
      };

    };

  };
}
