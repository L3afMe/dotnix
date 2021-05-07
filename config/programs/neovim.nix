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
    colorschemePkg = pkgs.vimUtils.buildVimPlugin {
      name = "rps-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "L3afMe";
        repo = "rose-pine-sepia-nvim";
        rev = "dc76c8c947322f256ca400c046a69dae435bfc21";
        sha256 = "1b40xbdh38ch2v1grx1plgnbv72jk1y7gjmza3iv2nbz4wxxgqmy";
      };
    };
  };
}
