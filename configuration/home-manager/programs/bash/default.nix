{ config, pkgs, lib, ... }:
let
  conf = import ../../../../config { inherit pkgs; };
  shellPkg = conf.helpers.getPkg conf.user.programs.shell;
in
{
  config = lib.mkIf (shellPkg == pkgs.bash) {
    programs.bash = import ./config.nix { inherit pkgs conf lib; };
    # home.file     = import ./external   { inherit pkgs conf lib; }; 
  };
}
