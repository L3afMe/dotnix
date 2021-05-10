{ pkgs, ... }:
with pkgs.vimPlugins; {
  plugin = rust-vim;
  config = ''
    let g:rust_clip_command = 'xclip -selection clipboard'
  '';
}
