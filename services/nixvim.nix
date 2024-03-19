{ pkgs, lib, ... }:

{
  # ...
  inputs.nixvim = {
    url = "github:nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    # url = "github:nix-community/nixvim/nixos-23.05";

    inputs.nixpkgs.follows = "nixpkgs";
  };
  
  imports = [
    # For home-manager
    #nixvim.homeManagerModules.nixvim
    # For NixOS
    nixvim.nixosModules.nixvim
    # For nix-darwin
    #nixvim.nixDarwinModules.nixvim
  ];

programs.nixvim.enable = true;

}