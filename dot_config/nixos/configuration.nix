# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
  # ThinkPad-specific settings

  let
    thinkpadConfig = pkgs.writeText "thinkpad-config" ''
      Section "InputClass"
        Identifier "keyboard defaults"
        MatchIsKeyboard "on"
        Option "XkbOptions" "terminate:ctrl_alt_bksp"
        # Set the Fn keys to their expected functions
        Option "XkbOptions" "misc:media_keys_enable"
      EndSection
    '';
  in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Load ThinkPad-specific kernel module
  boot.kernelModules = [ "thinkpad_acpi" ];

  networking.hostName = "blacksquare"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

   systemd.extraConfig = ''
      DefaultTimeoutStopSec=10s
      '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Hong_Kong";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_HK.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Display manager settings.
#  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  # DE/WM settings
  # currently installed
  # xfce
  # i3
  # awesome
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.sessionPackages = [ pkgs.hyprland ];
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    # extraConfig = ''
    #   ${thinkpadConfig}
    # '';
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bs = {
    isNormalUser = true;
    description = "bs";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.fonts = with pkgs; [
    fira-code
    font-awesome
    nerdfonts
    jetbrains-mono
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    xclip
    wget
    curl
    neovim
    unzip
    awesome
    i3
    qtile
    git
    htop
    gcc
    python3
    kitty
    alacritty
    fish
    arandr
    rofi
    gh
    chromium
    ranger
    nnn
    lf
    waybar
    wofi
    nix-prefetch-git
    wl-clipboard
    neofetch
    weechat
    weechatScripts.weechat-matrix
    neovide
    syncthing
    qutebrowser
    magic-wormhole
    chezmoi
    xmonad
    xmobar
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.hyprland.enable = true;

  programs.fish.enable = true;

  # services.xdg-desktop-portal.enable = true;

  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    shadow = true;
  };

  # List services that you want to enable:
  services.logind.extraConfig = ''
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
    HandleLidSwitchDocked=suspend
  '';
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
