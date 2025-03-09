{...}:

{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$mod" = "alt";
    "$reverse" = "grave";
    "$key" = "Tab";


    # Normal binds
    bind =
      [
        # Alt+Tab to switch between windows
        "$mod, $key, exec, hyprswitch gui --mod-key $mod --key $key --close mod-key-release --reverse-key=key=$reverse && hyprswitch dispatch"
        "$mod $reverse, $key, exec, hyprswitch gui --mod-key $mod --key $key --close mod-key-release --reverse-key=key=$reverse && hyprswitch dispatch -r"

        # Default behaviours
        "$mainMod, C, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exec, uwsm stop"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"

        # Move between workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, right, workspace, e+1"
        "$mainMod, left, workspace, e-1"

        # Clipboard History Mac Style
        "$mainMod $mod, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mainMod, ${toString ws}, workspace, ${toString ws}"
            "$mainMod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));

    # Mouse binds
    bindm = [
      # Move windows
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];
  };
}