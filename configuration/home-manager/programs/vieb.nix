{ config, pkgs, ... }:
let
  conf = (import ../../../config { inherit pkgs; });
in
{
  home.file = with conf.programs.vieb; {
    vieb = with configOptions; { 
      target = ".config/Vieb/viebrc";
      text = ''
        # Options
        set fontsize=12
        set ${if caseInsensitive then "" else "no"}ignorecase
        set ${if restoreTabs     then "" else "no"}restoretabs
        set ${if mouseSupport     then "" else "no"}mouse
        set search=${search}
        set vimcommand=${editorCommand}

        # Binds
        nunmap p
        nunmap t
        nmap go <action.toExploreMode>
        nmap gO <action.openNewTabWithCurrentUrl>
        nmap O <action.openNewTab><action.toExploreMode>
        nmap o <action.toExploreMode><C-a><BS>
        cmap <Up> <action.commandHistoryPrevious>
        cmap <Down> <action.commandHistoryNext>
        cmap <C-W>v <action.openNewTab>

        ${extraConfig}

        # Colorscheme
        colorscheme ${themeOptions.colorscheme}'';
    };

    vieb-theme = with conf.theme.viebColors; { 
      target = ".config/Vieb/colors/nix.css";
      text = ''
        /*
         * Vars
         */
        :root {
          --bg: ${background};
          --fg: ${background};
          --bg-selected: ${tab.background.selected};
          --bg-normal: ${tab.background.normal};
        }

        /*
         * Navbar
         */
        #logo {
          display: none;
        }

        /*
         * Bar at bottom
         */
        #app {
          flex-direction: column-reverse;
        }

        #url-hover {
          bottom: 4em;
        }

        #suggest-dropdown {
          top: auto;
          bottom: 2.1em;
          flex-direction: column-reverse;
        }

        #mode-suggestions {
          top: auto;
          bottom: 2em;
          flex-direction: column-reverse;
        }

        .bottomright {
          right: .7em;
          bottom: 4em;
        }

        .bottomleft {
          left: .7em;
          bottom: 4em;
        }

        .topright {
          right: .7em;
          top: .7em;
        }

        .topleft {
          left: .7em;
          top: .7em;
        }

        #app.tabshidden #url-hover, #app.navigationhidden #url-hover {
          bottom: 2em;
        }

        #app.tabshidden.navigationhidden #url-hover {
          bottom: 0;
        }

        #app.navigationhidden #suggest-dropdown {
          top: auto;
          bottom: .1em;
        }
      '';
    };

    vieb-colors-only-theme = with conf.theme.viebColors; { 
      target = ".config/Vieb/colors/nix-default.css";
      text = ''
        :root {
          --bg: ${background};
          --fg: ${foreground};
          --tab-background: ${tab.background.normal};
          --tab-suspended: #000;
          --visible-tab: ${tab.background.selected};
          --tab-split: ${accent};
          --tab-audio: #09f;
          --tab-muted: #fff;
          --tab-muted-playing: #ff3;
          --tab-crashed: #f00;
          --tab-scrollbar: #5ff;
          --container-background: none;
          --mode-normal-fg: #eee;
          --mode-normal-bg: none;
          --mode-command-fg: #f33;
          --mode-command-bg: none;
          --mode-insert-fg: #3f3;
          --mode-insert-bg: none;
          --mode-follow-fg: #f3f;
          --mode-follow-bg: none;
          --mode-explore-fg: #3ff;
          --mode-explore-bg: none;
          --mode-search-fg: #ff3;
          --mode-search-bg: none;
          --mode-pointer-fg: #777;
          --mode-pointer-bg: #fff;
          --mode-visual-fg: #000;
          --mode-visual-bg: #3af;
          --url-default: #666;
          --url-search: #f90;
          --url-searchwords: #fcf;
          --url-url: #3ff;
          --url-suggest: #3f3;
          --url-file: #ff9;
          --url-invalid: #f33;
          --follow-text: #111;
          --follow-url-bg: #cff;
          --follow-url-border: #5cc;
          --follow-click-bg: #fcc;
          --follow-click-border: #c55;
          --follow-insert-bg: #cfc;
          --follow-insert-border: #5c5;
          --follow-onclick-bg: #ffc;
          --follow-onclick-border: #cc5;
          --follow-other-bg: #ccc;
          --follow-other-border: #aaa;
          --suggestions-border: #777;
          --suggestions-bg: #444;
          --suggestions-selected: #666;
          --suggestions-url: #bff;
          --suggestions-file: #ffb;
          --notification-border: #111;
          --notification-date: #aaa;
          --notification-permission: #aaa;
          --notification-error: #f33;
          --notification-warning: #fd0;
          --notification-info: #0cf;
          --notification-success: #3f3;
          --url-hover-fg: #000;
          --url-hover-bg: #fff9 
        }
      '';
    };
  };
}
