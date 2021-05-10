{ pkgs }:
with pkgs.new-vim-shit.vimPlugins; {
    plugin = markdown-preview-nvim;
    config = ''
      let g:mkdp_auto_start = 1
      let g:mkdp_browser = 'qutebrowser'
    '';
}
