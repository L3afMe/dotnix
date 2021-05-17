{ pkgs, lib, ... }:
let
  config = import ../../config { inherit pkgs; };
  termBase16 = map (builtins.replaceStrings [ "#" ] [ "" ])
    config.theme.ttyBase16;

  getBin = config.helpers.getBin;
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # MBR dualboot
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;

    loader = {
      grub = {
        enable = true;

        version = 2;
        device = "/dev/sda";

        extraEntries = ''
          menuentry "Windows 10" {
            chainloader (hd0,1)+1
          }
        '';
      };
    };
  };

  networking = {
    hostName = "L3af-NixOS";
    wireless.enable = false;

    useDHCP = false;
    interfaces = {
      enp0s25.useDHCP = true;
    };

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  console = {
    colors = termBase16;
    font = "Lat2-Terminus16";
    earlySetup = true;
    keyMap = "us";
  };

  powerManagement.cpuFreqGovernor = "performance";

  programs = {
    xwayland.enable = true;
    command-not-found.enable = false;

    cowsay = {
      enable = true;
      
      cows = {
        giraffe = ''
    $thoughts
      $thoughts
        $thoughts
              ^__^
              (oo)
              (__)\\
                \\ \\
                  \\ \\
                  \\ \\
                    \\ \\
                    \\ \\
                      \\ \\
                      \\ \\
                        \\ \\______
                        \\       )\\/\\/\\
                          ||-----|
                          ||    ||
        '';
      };
    };
  };

  services.xserver =
    with config.user.xserver;
  {
    enable = enable;
    dpi = 96;

    layout = "us";

    libinput = {
      enable = true;

      mouse.accelProfile = "flat";
      touchpad.naturalScrolling = true;
    };

    displayManager = {
      defaultSession = "none+${defaultSession}";

      lightdm.greeters.gtk = {
        enable = true;

        extraConfig = ''
          position = 10%,start 65%,center
          default-user-image = /assets/usericon
          xft-antialias = true
          xft-dpi = 96
          xft-hintstyle = slight
          xft-rgba = rgb
          indicators = ~clock;~power;
        '';
      };
    };
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;

    opengl = {
      enable = true;
      driSupport = true;
    };

    #zsa.enable = true;
  };

  users.users."${config.user.name}" = {
    isNormalUser = true;
    home = config.user.homeDir;
    extraGroups = [
      "adbusers"
      "audio"
      "video"
      "wheel"
    ];
  };

  environment = {
    binsh = "${pkgs.dash}/bin/dash";

    systemPackages = with pkgs; [
      curl
      dash
      file
      gcc
      unzip
      zip
    ] ++ config.user.systemPackages;
  };

  fonts = {
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
      twemoji-color-font
    ];

    fontconfig = {
      enable = true;
      dpi = 96;
    };
  };

  system.userActivationScripts = {
    batRebuildCache = {
      text = ''
        ${getBin pkgs.bat} cache --build
      '';
      deps = [ ];
    };
  };

  system.stateVersion = "21.05";
}

