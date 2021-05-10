{ pkgs, conf }:
let
  json = pkgs.formats.json {};
  cocConfig = conf.programs.neovim.configOptions.cocConfig;
  output = json.generate "coc-settings.json" cocConfig;
in
{
  target = ".config/nvim/coc-settings.json";
  source = output;
}
