{ inputs, pkgs, ... }:
with pkgs.lib;
let
  config = import ../../config { inherit pkgs; };
in
{
  imports = import ./programs;

  home = {
    homeDirectory = "/home/${config.user}";
    username = config.user;

    packages = with pkgs; [
      # Terminal
      kitty

      # Browser - Update to vieb when fixed https://github.com/NixOS/nixpkgs/pull/115708
      qutebrowser

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
      EDITOR = "nvim";
    };

    stateVersion = "21.03";
  };
}
