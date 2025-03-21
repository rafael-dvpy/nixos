# Edit this configuration file to define what should be installed on your system.  Help is available in the 
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, inputs, nixpkgs, ... }:

# Gerar o arquivo de layout personalizado com a modificação
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/custom-keyboard.nix
  ];


  custom-keyboard.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      rafael = import ./home.nix;
    };
  };

  # Fonts
  fonts.fontDir.enable = true;

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Git
  programs.git.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary networking.proxy.default = "http://user:password@proxy:port/"; 
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT =
      "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.bspwm = {
    enable = true;
    configFile = "/home/rafael/.config/bspwm/bspwmrc";
    sxhkd = {
      configFile = "/home/rafael/.config/sxhkd/sxhkdrc";
    };
  };

  programs.zsh.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # services.xserver.xkb.extraLayouts.custom-ctrl-esc = {
  #   description = "Custom layout with Right Ctrl and Caps Lock remapped";
  #   languages = [ "br" ];
  #   symbolsFile = pkgs.writeText "xkb-custom-ctrl-esc" ''
  #     xkb_symbols "custom-ctrl-esc" {
  #       keycode 105 = equal plus F12  // Ctrl Direito vira =, + (Shift) e F12 (Fn)
  #       keycode 66  = Escape          // Caps Lock vira Esc
  #       keycode 66  = Escape          // Caps Lock vira Esc
  #     };
  #   '';
  # };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rafael = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Rafael";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
    packages = with pkgs; [
      #  thunderbird
      stremio
      neovim
      dmenu
      alacritty
      pavucontrol
      xorg.xmodmap
      discord
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    sxhkd
    home-manager
    feh
  ];

  # Some programs need SUID wrappers, can be configured further or are started in user sessions. 
  # programs.mtr.enable = true; programs.gnupg.agent = {
  #   enable = true; enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.openssh.enable = true;

  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; 
  # networking.firewall.allowedUDPPorts = [ ... ]; Or disable the firewall altogether. 
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data, like file 
  # locations and database versions on your system were taken. It‘s perfectly fine and recommended to leave 
  # this value at the release version of the first install of this system. Before changing this value read the 
  # documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
