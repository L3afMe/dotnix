{ pkgs, conf, lib }:
with conf.programs;
let
  boolToStr = check: if check then "true" else "false";
  getBin = conf.helpers.getBin;
in
{
  enable = true;

  shellAliases = {
    ".." = "cd ..";
    ls = "ls -liah";

    rebuild = ''
      cd ${conf.user.homeDir}/dotnix/ && git add . &&
        sudo nixos-rebuild switch --flake ".#l3af" && cd -
    '';
    gens = ''
      sudo nix-env -p /nix/var/nix/profiles/system \
        --list-generations | tail
      '';
    manixfzf = ''
      ${getBin pkgs.manix} "" | grep "^# " |
        sed "s/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //" |
        ${getBin pkgs.fzf} --preview="${getBin pkgs.manix} '{}'"
    '';
  };

  initExtra = ''
    #> Syntax: bash

    function run() {
      nix run nixpkgs#$1
    }

    search() {
      nix search "''${@:-nixpkgs}" ".*" |
        grep "^\* " | sed "s/^\* //;s/ (.*//" |
        sed -r "s/\x1b\[([0-9]{1,2}(;[0-9]{1,2})?)?m//g" |
        ${getBin pkgs.fzf} --preview="nix search nixpkgs '^{}$'"
    }

    function updatePrompt() {
      dir=$(pwd);
      if [ ${boolToStr true} == true ]
      then
        dir=$(echo $dir | sed "s|${conf.user.homeDir}|~|g")
      fi

      if [ ${boolToStr true} == true ]
      then
        startDir=$dir
        trim=$(echo $dir | sed -e "s|^/||g")
        if [ $(echo $trim | sed -e "s|/| |g" | wc -w) -ge 3 ]
        then
          trim=$(echo $trim | rg -o "s|(/[^/]*){2}$||g")
          trim=$(echo $trim | awk '{gsub(/^[ \n]+|[ \n]+$/, "")} { print $0 }')
          dir="..$trim"
        fi
      fi

      PS1="$dir | "
    }

    updatePrompt

    function cd() {
      command cd $@; updatePrompt
    }

    function cdc() {
      cd $@ && clear
    }

    battail() {
      tail -f "$1" | bat --paging=never -l lo
    }

    alias cat=bat
  '';
}
