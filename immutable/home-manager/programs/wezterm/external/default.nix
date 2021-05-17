{ pkgs, conf, lib }:
with conf.programs.neovim;
{
  # Stupid lua config
  weztermConfig = import ./config.nix { inherit conf lib; };
}
