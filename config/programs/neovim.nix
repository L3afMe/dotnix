#
# ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
# ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
# ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
# ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
# ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
# ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
#          https://github.com/neovim/neovim

{ pkgs, ... }:
rec {
  configOptions = {
    extraConfig = ''
    '';

    extraPlugins = with pkgs.vimPlugins; [
    ];

    cocConfig = {
      "rust-analyzer.cargo.allFeatures" = true;
      "rust-analyzer.lens.methodReferences" = true;
      "rust-analyzer.checkOnSave.command" = "clippy";
      "smali.enable" = true; 

      languageserver = {
        nix = {
          command = "${pkgs.rnix-lsp}/bin/rnix-lsp";

          filetypes = [
            "nix"
          ];
        };
      };
    };
  };

  themeOptions = {
    # Use "nix" to generate a colorscheme based off
    # of the colors defined at the end of this file
    # Themes can provide a custom colorscheme named
    # "nvimColors" if you prefer more customization
    # which can override the nvimColors found below
    colorscheme = "nix";

    # Can be used to download a prebuilt colorscheme
    colorschemePkg = pkgs.vimPlugins.zephyr-nvim; 
  };
}
