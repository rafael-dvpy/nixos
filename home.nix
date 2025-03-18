{ config, pkgs, ... }:

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
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs;[
    hello
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    nerd-fonts.hack
    ripgrep
    libgcc
    unzip
    gnumake
    xclip
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

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
