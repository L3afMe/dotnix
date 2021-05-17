{ config, pkgs, lib, ... }:
let
  conf = (import ../../../../config { inherit pkgs; });
  terminalPkg = conf.helpers.getPkg conf.user.programs.terminal;
in
{
  config = lib.mkIf (terminalPkg == pkgs.wezterm) {
    programs.wezterm = import ./config.nix { inherit pkgs conf lib; };
    #home.file        = import ./external   { inherit pkgs conf lib; }; 
  };
}
