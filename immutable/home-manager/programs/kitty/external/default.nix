{ pkgs, conf, lib }:
with conf.programs.kitty;
{
  # Kitty colorscheme generated from nix theme
  kittyNixTheme = import ./colorscheme.nix { inherit conf lib; };
}
