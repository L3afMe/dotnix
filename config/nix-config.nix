# ███╗   ██╗██╗██╗  ██╗
# ████╗  ██║██║╚██╗██╔╝
# ██╔██╗ ██║██║ ╚███╔╝ 
# ██║╚██╗██║██║ ██╔██╗ 
# ██║ ╚████║██║██╔╝ ██╗
# ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝
#      Nix config

{ inputs, system, nixpkgs, ... }:
let
  user = import ./config.nix { pkgs = nixpkgs; };
in
rec {
  autoOptimiseStore = true;

  binaryCaches = [
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
  ];

  binaryCachePublicKeys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixPath = let path = toString ../.; in [
    "repl=${path}/repl.nix"
    "home-manager=${inputs.home}"
    "nixpkgs=${nixpkgs}"
    "nixos-config=${path}"
  ];

  registry = {
    system.flake = inputs.self;
    nixpkgs.flake = nixpkgs;
    default.flake = nixpkgs;
    home-manager.flake = inputs.home;
  };

  package = nixpkgs.legacyPackages."${system}".nixFlakes;

  trustedBinaryCaches = binaryCaches;
  trustedUsers = [ "root" user.name ];
}
