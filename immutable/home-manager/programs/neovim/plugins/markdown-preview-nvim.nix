{ pkgs }:
with pkgs.vimPlugins; 
let
  config = import ../../../../../config { inherit pkgs; };
  browser = config.user.programs.browser;
  getBin = config.helpers.getBin;
  browserBin = getBin browser;
in
{
    plugin = markdown-preview-nvim;
    config = ''
      let g:mkdp_auto_start = 1
      let g:mkdp_browser = '${browserBin}'
    '';
}
