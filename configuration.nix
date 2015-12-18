# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "wlat531"; # Define your hostname.
  #networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  # Select internationalisation properties.
   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
   };

  # Set your time zone.
  time.timeZone = "EST5EDT";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
     wget
     networkmanager
     bspwm
     atom
     sxhkd
     dmenu
     git
     tint2
     rofi
     networkmanagerapplet
     xfce.xfce4volumed
     xfce.xfce4_power_manager
     xfce.xfce4mixer
     polkit_gnome
     libreoffice          # docs, spreadsheets, etc.
     lxappearance
      # xfce
      gtk                  # To get GTK+'s themes
      gnome.gnomeicontheme # more icons
      hicolor_icon_theme   # icons for thunar
      shared_mime_info

      xfce.exo
      xfce.gtk_xfce_engine
      xfce.gvfs            # auto mounting
      xfce.libxfce4ui
      xfce.libxfcegui4
      xfce.thunar          # file manager
      xfce.thunar_volman   # auto mounting
      xfce.xfce4icontheme  # for thunar
      xfce.xfce4settings
      xfce.xfconf

      zathura              # pdf viewer
   ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  #services.xserver.desktopManager.kde4.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.michael = {
     isNormalUser = true;
     uid = 1000;
   };

  #Touchpad
  #services.xserver.synaptics.enable = true;
  #services.xserver.synaptics.twoFingerScroll = true;
  #services.xserver = {
  services.xserver.synaptics = {
      enable = true;
      twoFingerScroll = true;
      accelFactor = "0.002";
      buttonsMap = [ 1 3 2 ]; # enables right clicking with two fingers
      maxSpeed = "2.0";
    };
  #zsh
  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  #fonts
  # XXX: add more fonts!
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = false;

    # terminus I use for rxvt-unicode
    # see https://github.com/chaoflow/chaoflow.skel.home/blob/master/.Xdefaults
    fonts = [
       #pkgs.cantarell_fonts
       #pkgs.dejavu_fonts
       #pkgs.dosemu_fonts
       #pkgs.freefont_ttf
       #pkgs.liberation_ttf
       pkgs.terminus_font
       #pkgs.ubuntu_font_family
       #pkgs.ucsFonts
       #pkgs.unifont
       #pkgs.vistafonts
       #pkgs.xlibs.fontadobe100dpi
       #pkgs.xlibs.fontadobe75dpi
       #pkgs.xlibs.fontadobeutopia100dpi
       #pkgs.xlibs.fontadobeutopia75dpi
       #pkgs.xlibs.fontadobeutopiatype1
       #pkgs.xlibs.fontarabicmisc
       pkgs.xlibs.fontbh100dpi
       pkgs.xlibs.fontbh75dpi
       pkgs.xlibs.fontbhlucidatypewriter100dpi
       pkgs.xlibs.fontbhlucidatypewriter75dpi
       pkgs.xlibs.fontbhttf
       pkgs.xlibs.fontbhtype1
       pkgs.xlibs.fontbitstream100dpi
       pkgs.xlibs.fontbitstream75dpi
       pkgs.xlibs.fontbitstreamtype1
       #pkgs.xlibs.fontcronyxcyrillic
       pkgs.xlibs.fontcursormisc
       pkgs.xlibs.fontdaewoomisc
       pkgs.xlibs.fontdecmisc
       pkgs.xlibs.fontibmtype1
       pkgs.xlibs.fontisasmisc
       pkgs.xlibs.fontjismisc
       pkgs.xlibs.fontmicromisc
       pkgs.xlibs.fontmisccyrillic
       pkgs.xlibs.fontmiscethiopic
       pkgs.xlibs.fontmiscmeltho
       pkgs.xlibs.fontmiscmisc
       pkgs.xlibs.fontmuttmisc
       pkgs.xlibs.fontschumachermisc
       pkgs.xlibs.fontscreencyrillic
       pkgs.xlibs.fontsonymisc
       pkgs.xlibs.fontsunmisc
       pkgs.xlibs.fontwinitzkicyrillic
       pkgs.xlibs.fontxfree86type1
    ];
  };
  #thunar mounts
  services.udisks2.enable = true;

  #suspend via logind
  services.acpid.enable = true;
  services.xserver.displayManager.desktopManagerHandlesLidAndPower = false;
  services.logind.extraConfig = ''
   HandleLidSwitch=suspend
  '';

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
