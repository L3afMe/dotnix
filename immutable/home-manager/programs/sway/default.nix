{ config, pkgs, lib, ... }:
let
  conf = (import ../../../../config { inherit pkgs; });
  wmPkg = conf.helpers.getPkg conf.user.programs.windowManager;
in
{
  config = lib.mkIf (wmPkg == pkgs.sway) {
    wayland.windowManager.sway = import ./config.nix { inherit pkgs conf lib; };

    home.packages = with pkgs; [
      sway-contrib.grimshot
      swaybg
      wl-clipboard
      mako
      waybar
      wofi
    ];
  };
}

