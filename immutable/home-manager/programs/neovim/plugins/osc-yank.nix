{ pkgs }:
with pkgs.vimPlugins; {
  plugin = vim-oscyank;
  config = ''
    vnoremap <leader>y :OSCYank<CR>
    autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif
  '';
}
