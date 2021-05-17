{ pkgs, conf, lib }:
with conf.programs.neovim;
let
  queries = import ./queries.nix;
in
{
  # CoC setting generated from configOptions.cocSettings
  neovimCocSettings = import ./coc-settings.nix { inherit pkgs conf; };

  # Theme generated from theme.nvimColors
  # when colorscheme is set to "nix"
  neovimNixTheme = lib.mkIf (themeOptions.colorscheme == "nix")
      (import ./colorscheme.nix { inherit conf lib; });

  # Treesitter scm's
  nixHighlights = queries.nixHighlights;
  nixInjections = queries.nixInjections;
}
