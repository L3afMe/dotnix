{ config, pkgs, ... }:

{
  config = {
    # Git already in systemPackages from configuration.nix
    home.packages = with pkgs; [
      gitAndTools.hub
      gitAndTools.gh
    ];

    programs.git = {
      enable = true;

      userName = "L3af";
      userEmail = "L3afMeAlone";

      aliases = {
        co = "checkout";
        st = "status -sb";
      };

      delta.enable = true;
      extraConfig = {
        init. defaultBranch = "master";
        "pull".ff = "only";
        "commit".verbose = "true";
        hub.protocol = "git";
        advice.detachedHead = false;
      };
    };
  };
}
