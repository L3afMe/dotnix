{ home, inputs, nixpkgs, ... }:
let
  config = import ../config { pkgs = nixpkgs; };
in
nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";

  modules = [
    {
      nix = config.nix { inherit inputs system nixpkgs; };

      nixpkgs = 
        let
          inputs-overlays = _: _: {
            comma = import inputs.comma { pkgs = nixpkgs.legacyPackages."${system}"; };
          };

          nixpkgs-overlays = _: _: with inputs; {
            master = import master { inherit config system; };
            unstable = import unstable { inherit config system; };
            stable = import stable { inherit config system; };
            staging = import staging { inherit config system; };
            staging-next = import staging-next { inherit config system; };
          };
        in
        {
          overlays = with inputs; [
            inputs-overlays
            nixpkgs-overlays

            rust.overlay
            neovim-nightly.overlay
          ];
        };
    }

    ./system

    home.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users."${config.user.name}" = import ./home-manager;
      };
    }

    nixpkgs.nixosModules.notDetected
  ];

  specialArgs = { inherit inputs; };
}
