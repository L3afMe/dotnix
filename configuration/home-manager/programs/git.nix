{ config, pkgs, ... }:
let
  conf = (import ../../../config { inherit pkgs; }).programs.git.configOptions;
in
{
  config = {
    home.packages = with pkgs; [
      gitAndTools.hub
      gitAndTools.gh
    ];

    programs.git = {
      enable = true;

      userName = conf.user.name;
      userEmail = conf.user.email;

      aliases = {
        co = "checkout";
        st = "status -sb";
      };

      delta.enable = true;
      extraConfig = {
        init. defaultBranch = conf.defaultBranch;
        "pull".ff = "only";
        "commit".verbose = "true";
        hub.protocol = "git";
        advice.detachedHead = false;
      };
    };
  };
}
