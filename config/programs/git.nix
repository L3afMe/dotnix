#
#     ██████╗ ██╗████████╗
#    ██╔════╝ ██║╚══██╔══╝
#    ██║  ███╗██║   ██║
#    ██║   ██║██║   ██║
#    ╚██████╔╝██║   ██║
#     ╚═════╝ ╚═╝   ╚═╝
#  https://github.com/git/git

{ pkgs }:
let
  user = (import ../config.nix { inherit pkgs; });
in
rec {
  configOptions = {
    user = {
      name = "L3afMe";
      email = user.email;
    };

    defaultBranch = "master";
  };
}
