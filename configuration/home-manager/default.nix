{ inputs, pkgs, ... }:
with pkgs.lib;
let
  config = import ../../config { inherit pkgs; };
in
{
  imports = import ./programs;

  home = {
    homeDirectory = config.user.homeDir;
    username = config.user.name;

    packages = with pkgs; [
      # Terminal
      kitty

      # Browsers
      qutebrowser
      vieb

      # Screenshots
      maim

      # Run commands without installing package
      comma

      # Rust
      rustc
      cargo
      cargo-edit
      cargo-watch

      # Nixpkgs additions
      nixpkgs-fmt
      nixpkgs-review

      # Node PM
      yarn

      # Python
      python38Full
    ];

    sessionVariables = {
      EDITOR = config.user.programs.editor;
    };

    stateVersion = "21.03";
  };
}
