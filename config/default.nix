#
#  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
# ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
# ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
# ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
# ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
#  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
#         General config options, theming
#            is in ./theme/default.nix

{ pkgs, ... }:
rec {
  user = "l3af";
  email = "L3afMeAlone@gmail.com";
  browser = "qutebrowser";

  git = {
    user = {
      name = "L3afMe";
      email = email;
    };

    defaultBranch = "master";
  };

  kitty = {
    extraConfig = ''
    '';
  };

  neovim = {
    extraConfig = ''
nmap <C-l> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
      '';

    plugins = with pkgs.vimPlugins; [
      fzf-vim
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

  nix = import ./conf-nix.nix;
  theme = import ./theme { inherit pkgs; };
}
