{
  description = "Nix Infrastructure";
  inputs = {
    # Nixpkgs
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	};
 outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    ...
	} @ inputs: let 
	system = "x86_64-linux";
	    # Base nixpkgs-unstable
	    pkgs = import nixpkgs-unstable {
	      inherit system;
        # REMOVED FROM CONFIGURATION.NIX, added here
	      config.allowUnfree = true;
	      };
		in
	{
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      t480 = nixpkgs-unstable.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs;
        }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [
          ./configuration.nix
        ];
       };
      };
	  };
	}

	
