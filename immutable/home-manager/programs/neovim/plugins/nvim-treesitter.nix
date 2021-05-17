{ pkgs, luaConfig }:
with pkgs.vimPlugins; {
  plugin = nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
  config = ''
    set foldlevel=99
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
  '' + luaConfig ''
    ## Syntax: bash
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      query_linter = {
        enable = true,
      },
    }
  '';
}
