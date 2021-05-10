{ pkgs }:
with pkgs.vimPlugins; {
  plugin = vim-auto-save;
  config = ''
    let g:auto_save = 1
  '';
}
