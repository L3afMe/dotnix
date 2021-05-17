# Layout

```tree
root
 ├── flake.nix
 │     The main file to handle flakes
 ├── repl.nix
 │     Used for `nix repl` to include all system variables
 ├── config/
 │   │ Contains configurable files so that the
 │   │ system config doesn't need to be touched 
 │   ├── default.nix
 │   │     Contains all the config files for easy access
 │   ├── config.nix
 │   │     Change config like default programs, username,
 │   │     and additional packages you may want to install.
 │   │     By switching programs, the disabled program won't
 │   │     be installed anymore and it's config will be
 │   │     removed from your system until it is selected again.
 │   │     Packages can either be set like `pkgs.wofi` or
 │   │     {
 │   │       pkg = pkgs.wofi; 
 │   │       binName = "wofi";
 │   │       args = [ "──show" "run" ];
 │   │     }
 │   ├── helpers.nix
 │   │     Helper functions for reusing code. These shouldn't
 │   │     be touched
 │   ├── nix─config.nix
 │   │     Nix specific config options
 │   ├── theme.nix
 │   │     Change the selected colorcheme and toggle darkmode
 │   ├── programs/*.nix
 │   │     Config options for installable programs
 │   └── themes/*.nix
 │         Modify and add your own themes to apply system wide
 └── immutable/ (no go zone)
     │ Contains system config, nothing in here should ever
     │ need to be touched. If you find something that needs
     │ to be able to be configured, open an issue and I'll
     │ add a config option for it.
     ├── default.nix
     │     Contains the flake user config
     └── home─manager/
         ├── default.nix
         │     Set the user name/dir and install user programs specified
         │     in `/config/config.nix`
         ├── programs/
         │  ├── default.nix
         │  │     Contains all the program configs in a list for easy access
         │  └── */
         │     │  All subfolders of `home─manager/programs`
         │     │  follow a similar structure
         │     ├── default.nix
         │     │     Checks if the program is selected in `/config/config.nix`
         │     │     and include the programs config and external files if so
         │     ├── config.nix
         │     │     Configuration for the programs home─manager
         │     │     module
         │     └── external/
         │           Any external files that the program may
         │           need which aren't managed by home─manager
         └── system/
             │
             ├── default.nix
             │     Similar to `/etc/nixos/configuration.nix` on
             │     non flake systems, contains system config
             ├── hardware─configuration.nix
             │     Hardware configuration, make sure to override this
             │     on the initial install
             └── udev.nix
                   Udev rules required for flashing QMK firmware
```
