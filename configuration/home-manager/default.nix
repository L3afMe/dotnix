{ inputs, pkgs, config, lib, ... }:
let
  conf = import ../../config { inherit pkgs; };

  getBin = conf.helpers.getBin;
  getPkg = conf.helpers.getPkg;
in
{
  imports = import ./programs;

  home = with conf.user;
  {
    homeDirectory = homeDir;
    username = name;

    packages = 
    let
      programNames = builtins.attrNames programs;
      getPkgFromName = name:
        getPkg programs."${name}";
      userPkgs = builtins.map getPkgFromName programNames;
    in
    userPkgs ++ (with pkgs; [
      # Screenshots
      maim

      # Rust
      rustc
      cargo
      cargo-edit
      cargo-watch

      # Nixpkgs additions
      nixpkgs-fmt
      nixpkgs-review
    ]) ++ userPackages;

    sessionVariables = {
      EDITOR = getBin programs.editor;
    };

    stateVersion = "21.03";
  };
}
