rec {
  user = "l3af";

  nix = import ./conf-nix.nix;
  theme = import ./theme;
}
