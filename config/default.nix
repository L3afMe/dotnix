###################
#  DO NOT MODIFY  #
###################

{ pkgs, ... }:
rec {
  programs = import ./programs { inherit pkgs; };
  theme = import ./theme.nix { inherit pkgs; };
  user = import ./config.nix { inherit pkgs; };

  helpers = import ./helpers.nix { lib = pkgs.lib; };

  nix = import ./nix-config.nix;
}
