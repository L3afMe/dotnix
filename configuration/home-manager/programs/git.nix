{ config, pkgs, ... }:
let
  conf = import ../../../config { inherit pkgs; };
in
{
  config = {
    # Git already in systemPackages from configuration.nix
    home.packages = with pkgs; [
      gitAndTools.hub
      gitAndTools.gh
    ];

    programs.git = {
      enable = true;

      userName = conf.git.user.name;
      userEmail = conf.git.user.email;

      aliases = {
        co = "checkout";
        st = "status -sb";
      };

      delta.enable = true;
      extraConfig = {
        init. defaultBranch = conf.git.defaultBranch;
        "pull".ff = "only";
        "commit".verbose = "true";
        hub.protocol = "git";
        advice.detachedHead = false;
      };
    };
  };
}
