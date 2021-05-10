{ viebColors }:
{
  nix-default = import ./nix-default.nix { inherit viebColors; };
  nix = import ./nix-default.nix { inherit viebColors; };
}
