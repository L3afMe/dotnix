{ pkgs, luaConfig }:
with pkgs.vimPlugins; {
  plugin = telescope-nvim;
  config = ''
    nnoremap <leader>tf <cmd>Telescope find_files<cr>
    nnoremap <leader>tg <cmd>Telescope live_grep<cr>
    nnoremap <leader>tb <cmd>Telescope buffers<cr>
    nnoremap <leader>th <cmd>Telescope help_tags<cr>
  '';
}
