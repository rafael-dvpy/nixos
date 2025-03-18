{ config, lib, pkgs, ... }:

with lib;

let
  keyboardLayout = pkgs.writeText "xkb-custom-layout" ''
    ! Make Right Control work as:
    ! - "=" when pressed alone
    ! - "+" when pressed with Shift
    ! - "F12" when pressed with Fn (ISO_Level3_Shift)
    keycode 105 = equal plus F12

    ! Remap Caps Lock to Escape
    keycode 66 = Escape
  '';
in
{
  options.customKeyboard.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable custom Caps Lock and Right Control key mapping.";
  };

  config = mkIf config.customKeyboard.enable {
    services.xserver.displayManager.sessionCommands = ''
      ${pkgs.xorg.xmodmap}/bin/xmodmap ${keyboardLayout}
    '';
  };
}
