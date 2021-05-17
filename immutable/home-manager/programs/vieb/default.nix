{ config, pkgs, lib, ... }:
let
  conf = (import ../../../../config { inherit pkgs; });
in
{
  home.file = with conf.programs.vieb; {
    vieb = with configOptions; {
      target = ".config/Vieb/viebrc";
      text = ''
        "" Options
        set fontsize=12
        set ${if caseInsensitive then "" else "no"}ignorecase
        set ${if restoreTabs     then "" else "no"}restoretabs
        set ${if mouseSupport    then "" else "no"}mouse
        set search=${search}
        set vimcommand=${editorCommand}
        set permissionmediadevices=allow

        "" Binds
        " Only use O/gO to open new tag
        nunmap t
        " Use R to reload
        nunmap r
        nunmap p
        nmap I <:devtools>
        nmap go <action.toExploreMode>
        nmap gO <action.openNewTabWithCurrentUrl>
        nmap O <action.openNewTab><action.toExploreMode>
        nmap o <action.toExploreMode><C-a><BS>
        cmap <Up> <action.commandHistoryPrevious>
        cmap <Down> <action.commandHistoryNext>
        cmap <C-W>v <action.openNewTab>
        emap <Up> <action.prevSuggestion>
        emap <Down> <action.nextSuggestion>

        ${extraConfig}

        " Colorscheme
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
          --bg:                      ${background};
          --fg:                      ${foreground};
          --tab-background:          ${tab.background.normal};
          --tab-suspended:           ${tab.suspended};
          --visible-tab:             ${tab.background.selected};
          --tab-split:               ${accent};
          --tab-audio:               ${tab.audio};
          --tab-muted:               ${tab.muted};
          --tab-muted-playing:       ${tab.muted-playing};
          --tab-crashed:             ${tab.crashed};
          --tab-scrollbar:           ${tab.scrollbar};
          --container-background:    none;
          --mode-normal-fg:          ${modes.normal.fg};
          --mode-normal-bg:          ${modes.normal.bg};
          --mode-command-fg:         ${modes.command.fg};
          --mode-command-bg:         ${modes.command.bg};
          --mode-insert-fg:          ${modes.insert.fg};
          --mode-insert-bg:          ${modes.insert.bg};
          --mode-follow-fg:          ${modes.follow.fg};
          --mode-follow-bg:          ${modes.follow.bg};
          --mode-explore-fg:         ${modes.explore.fg};
          --mode-explore-bg:         ${modes.explore.bg};
          --mode-search-fg:          ${modes.search.fg};
          --mode-search-bg:          ${modes.search.bg};
          --mode-pointer-fg:         ${modes.pointer.fg};
          --mode-pointer-bg:         ${modes.pointer.bg};
          --mode-visual-fg:          ${modes.visual.fg};
          --mode-visual-bg:          ${modes.visual.bg};
          --url-default:             ${url.default};
          --url-search:              ${url.search};
          --url-searchwords:         ${url.searchwords};
          --url-url:                 ${url.url};
          --url-suggest:             ${url.suggest};
          --url-file:                ${url.file};
          --url-invalid:             ${url.invalid};
          --url-hover-fg:            ${url.hover.fg};
          --url-hover-bg:            ${url.hover.bg};
          --follow-text:             ${follow.text};
          --follow-url-bg:           ${follow.url.bg};
          --follow-url-border:       ${follow.url.border};
          --follow-click-bg:         ${follow.click.bg};
          --follow-click-border:     ${follow.click.border};
          --follow-insert-bg:        ${follow.insert.bg};
          --follow-insert-border:    ${follow.insert.border};
          --follow-onclick-bg:       ${follow.onclick.bg};
          --follow-onclick-border:   ${follow.onclick.border};
          --follow-other-bg:         ${follow.other.bg};
          --follow-other-border:     ${follow.other.border};
          --suggestions-border:      ${suggestions.border};
          --suggestions-bg:          ${suggestions.bg};
          --suggestions-selected:    ${suggestions.selected};
          --suggestions-url:         ${suggestions.url};
          --suggestions-file:        ${suggestions.file};
          --notification-border:     ${notifications.border};
          --notification-date:       ${notifications.date};
          --notification-permission: ${notifications.permission};
          --notification-error:      ${notifications.error};
          --notification-warning:    ${notifications.warning};
          --notification-info:       ${notifications.info};
          --notification-success:    ${notifications.success};
        }
      '';
    };
  };
}
