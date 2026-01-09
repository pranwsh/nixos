
```nix
# hyprscrolling.nix
{ ... }:

{
  wayland.windowManager.hyprland.settings = {

    # Keybinds (Vim-like)
    bind = [
      #### Focus navigation (hjkl-ish)
      "SUPER, H, hyprscrolling:focus, l"
      "SUPER, L, hyprscrolling:focus, r"

      #### Move window between columns (Shift + h/l)
      "SUPER SHIFT, H, hyprscrolling:movewindowto, l"
      "SUPER SHIFT, L, hyprscrolling:movewindowto, r"

      #### Scroll layout (Alt + h/l = pixels)
      "SUPER ALT, H, hyprscrolling:move, -200"
      "SUPER ALT, L, hyprscrolling:move, +200"

      #### Scroll layout by columns (Alt+Shift + h/l)
      "SUPER ALT SHIFT, H, hyprscrolling:move, -col"
      "SUPER ALT SHIFT, L, hyprscrolling:move, +col"

      #### Resize current column (j/k)
      "SUPER, J, hyprscrolling:colresize, -0.05"
      "SUPER, K, hyprscrolling:colresize, +0.05"

      #### Cycle configured widths (Shift + j/k)
      "SUPER SHIFT, J, hyprscrolling:colresize, -conf"
      "SUPER SHIFT, K, hyprscrolling:colresize, +conf"

      #### Fit / centering controls
      "SUPER, F, hyprscrolling:fit, active"
      "SUPER SHIFT, F, hyprscrolling:fit, all"
      "SUPER, C, hyprscrolling:togglefit"

      #### Column power moves
      "SUPER, P, hyprscrolling:promote"
      "SUPER, comma, hyprscrolling:swapcol, l"
      "SUPER, period, hyprscrolling:swapcol, r"

      #### Move entire column to workspace (Ctrl + number)
      "SUPER CTRL, 1, hyprscrolling:movecoltoworkspace, 1"
      "SUPER CTRL, 2, hyprscrolling:movecoltoworkspace, 2"
      "SUPER CTRL, 3, hyprscrolling:movecoltoworkspace, 3"
      "SUPER CTRL, 4, hyprscrolling:movecoltoworkspace, 4"
      "SUPER CTRL, 5, hyprscrolling:movecoltoworkspace, 5"
      "SUPER CTRL, 6, hyprscrolling:movecoltoworkspace, 6"
      "SUPER CTRL, 7, hyprscrolling:movecoltoworkspace, 7"
      "SUPER CTRL, 8, hyprscrolling:movecoltoworkspace, 8"
      "SUPER CTRL, 9, hyprscrolling:movecoltoworkspace, 9"
      "SUPER CTRL, 0, hyprscrolling:movecoltoworkspace, 10"

      #### Special workspace (Ctrl+s)
      "SUPER CTRL, S, hyprscrolling:movecoltoworkspace, special"
    ];
  };
}
```
