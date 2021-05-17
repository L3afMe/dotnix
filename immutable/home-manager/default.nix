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

      # Search through nixpkgs packages, options and home-manager options
      manix

      # System utils
      bat
      bat-extras.batman
      bat-extras.batgrep
      bat-extras.batdiff
      bat-extras.prettybat
      fd
      fzf
      ripgrep
    ]) ++ userPackages;

    sessionVariables = {
      EDITOR = getBin programs.editor;
      MANPAGER = "sh -c 'col -bx | ${getBin pkgs.bat} -l man -p'";
    };

    stateVersion = "21.03";
  };
}
