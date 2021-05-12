{ pkgs, conf, lib }:
with conf.programs;
{
  enable = true;

  shellAliases = {
    ls = "ls -liah";
    ".." = "cd ..";
    rebuild = "sudo nixos-rebuild switch --flake \".#l3af\"";
    gens = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
  };

  initExtra = ''
    ## Syntax: bash

    function run() {
      nix run nixpkgs#$1
    }

    function cdc() {
      cd $@ && clear
    }

    alias cat=bat
  '';
}
