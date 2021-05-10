{ config, pkgs, lib, ... }:
let
  conf = (import ../../../../config { inherit pkgs; });
  terminalPkg = conf.helpers.getPkg conf.user.programs.editor;
in
{
  config = lib.mkIf (terminalPkg == pkgs.kitty) {
    programs.kitty = import ./config.nix { inherit pkgs conf lib; };
    home.file     = import ./external   { inherit pkgs conf lib; }; 
  };
}
