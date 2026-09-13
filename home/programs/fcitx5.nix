{ ... }:
{
  xdg.configFile."fcitx5/profile" = {
    force = true;
    text = ''
      [Groups/0]
      Name=Default
      Default Layout=gb
      DefaultIM=keyboard-gb

      [Groups/0/Items/0]
      Name=keyboard-gb
      Layout=

      [Groups/0/Items/1]
      Name=pinyin
      Layout=

      [Groups/0/Items/2]
      Name=mozc
      Layout=

      [GroupOrder]
      0=Default
    '';
  };

  xdg.configFile."fcitx5/config" = {
    force = true;
    text = ''
      [Hotkey/TriggerKeys]
      0=Control+space

      [Hotkey/EnumerateForwardKeys]
      0=

      [Hotkey/EnumerateBackwardKeys]
      0=
    '';
  };
}
