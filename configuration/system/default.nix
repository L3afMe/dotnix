{ pkgs, lib, ... }:
let
  config = import ../../config { inherit pkgs; };
in
{
  imports = [
    ./hardware-configuration.nix
    ./udev.nix
  ];

  # MBR dualboot
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;

    loader = {
      grub = {
        enable = true;

        version = 2;
        useOSProber = true;
        device = "/dev/sda";
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
    colors = config.theme.base16;
    font = "Lat2-Terminus16";
    earlySetup = true;
    keyMap = "us";
  };

  powerManagement.cpuFreqGovernor = "performanc";

  programs.command-not-found.enable = false;

  services = {
    xserver = {
      enable = true;
      dpi = 96;

      layout = "us";

      libinput = {
        enable = true;

        mouse.accelProfile = "flat";
        touchpad.naturalScrolling = true;
      };

      displayManager = {
        defaultSession = "none+awesome";

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

      windowManager.awesome = {
        enable = true;

        luaModules = with pkgs.luaPackages; [
          luarocks
        ];
      };
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

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
      bat
      curl
      dash
      fd
      file
      gcc
      unzip
      xclip
      zip
    ];
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

  system.stateVersion = "21.05";
}

