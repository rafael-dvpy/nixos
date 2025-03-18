{ config, lib, pkgs, ... }:

{
  home.username = "rafael";
  home.homeDirectory = "/home/rafael";

  programs.git = {
    enable = true;
    userName = "rafael-dvpy";
    userEmail = "rafa.dev.oliveira@gmail.com";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    envExtra = ''
      export SOMEZSHVARIABLE="something"
    '';
    oh-my-zsh.enable = true;
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs;[
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    nerd-fonts.hack
    ripgrep
    libgcc
    unzip
    gnumake
    xclip
  ];

  #  xsession.windowManager.bspwm.enable = true;
  #  xsession.windowManager.bspwm.extraConfig = ''
  #    source ${config.home.homeDirectory}/nixos/config/bspwm/bspwmrc
  #  '';
  #  services.sxhkd.enable = true;
  #  services.sxhkd.extraConfig = ''
  #    source ${config.home.homeDirectory}/nixos/config/sxhkd/sxhkdrc
  #  '';

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/nvim";
    };
    ".config/bspwm" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/bspwm";
    };
    ".config/sxhkd" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/sxhkd";
    };
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
