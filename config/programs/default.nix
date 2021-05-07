{ pkgs, ... }:
rec {
  git = import ./git.nix { inherit pkgs; };
  kitty = import ./kitty.nix { inherit pkgs; };
  neovim = import ./neovim.nix { inherit pkgs; };
  vieb = import ./vieb.nix { inherit pkgs; };
}
