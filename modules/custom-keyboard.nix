{ config, pkgs, lib, ... }:

let
  # Defina o layout do teclado personalizado
  customLayout = pkgs.writeText "xkb-custom-layout" ''
    xkb_symbols "custom-ctrl-esc" {
      keycode 105 = equal plus F12  // Ctrl Direito vira =, + (Shift) e F12 (Fn)
      keycode 66  = Escape          // Caps Lock vira Esc
    };
  '';
in
{
  options = {
    custom-keyboard.enable = lib.mkEnableOption "Enable custom keyboard layout and remapping";
  };

  config = lib.mkIf config.custom-keyboard.enable {
    services.xserver.displayManager.sessionCommands = ''sleep 5 && ${pkgs.xorg.xmodmap}/bin/xmodmap -e "${customLayout}"'';
  };
}

