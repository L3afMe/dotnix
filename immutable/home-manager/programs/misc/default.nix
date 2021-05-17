{ config, pkgs, lib, ... }:
let
  conf = import ../../../../config { inherit pkgs; };
in
{
  home.file = import ./bat.nix { inherit conf lib; }; 
}
