{ config, pkgs, lib, ... }:
let
  conf = import ../../../../config { inherit pkgs; };
  editorPkg = conf.helpers.getPkg conf.user.programs.editor;
in
{
  config = lib.mkIf (editorPkg == pkgs.neovim-nightly) {
    programs.neovim = import ./config.nix { inherit pkgs conf lib; };
    home.file       = import ./external   { inherit pkgs conf lib; }; 
  };
}
