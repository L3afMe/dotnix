{ pkgs, luaConfig }:
with pkgs.vimPlugins; {
  plugin = playground;
  config = luaConfig ''
    require "nvim-treesitter.configs".setup {
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
      }
    }
  '';
}
