###################
#  DO NOT MODIFY  #
###################

{ pkgs, ... }:
rec {
  nix = import ./nix-config.nix;
  programs = import ./programs { inherit pkgs; };
  theme = import ./theme.nix { inherit pkgs; };
  user = import ./config.nix { inherit pkgs; };
}
