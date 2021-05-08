{
  description = "L3af's personal NixOS configuration.";

  inputs = {
    comma = {
      url = "github:Shopify/comma";
      flake = false;
    };

    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };

    new-vim-shit.url = "github:fortuneteller2k/nixpkgs/add-vimplugins";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    rust.url = "github:oxalica/rust-overlay";

    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/release-20.09";
    staging.url = "github:nixos/nixpkgs/staging";
    staging-next.url = "github:nixos/nixpkgs/staging-next";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.follows = "master";
  };

  outputs = { self, home, nixpkgs, ... } @ inputs:
    with nixpkgs.lib;
    {
      nixosConfigurations.l3af = import ./configuration {
        inherit home inputs nixpkgs;
      };

      l3af = self.nixosConfigurations.l3af.config.system.build.toplevel;
    };
}
