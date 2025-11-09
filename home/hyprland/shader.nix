# {pkgs, ...}: 
#
# let
#   glassShader = pkgs.writeText "window_edge_glass.frag" ''
#     #version 300 es
#     precision highp float;
#     in vec2 v_texcoord;
#     out vec4 fragColor;
#     uniform sampler2D tex;
#
#     void main() {
#       // Normalized UV
#       vec2 uv = v_texcoord;
#       vec4 base = texture(tex, uv);
#
#       // Distance to nearest edge
#       vec2 edge_dist = min(uv, 1.0 - uv);
#       float edge = min(edge_dist.x, edge_dist.y);
#
#       // Smooth falloff near edges for glow effect
#       float edge_width = 0.08;
#       float glow = smoothstep(edge_width, 0.0, edge);
#
#       // Calculate edge normal for refraction direction
#       vec2 center = vec2(0.5, 0.5);
#       vec2 edge_normal = normalize(center - uv);
#
#       // Refraction-style subtle distortion
#       vec2 offset = edge_normal * glow * 0.008;
#       vec4 refracted = texture(tex, uv + offset);
#
#       // Chromatic aberration for glass effect
#       float aberration = 0.004;
#       float r = texture(tex, uv + offset + edge_normal * aberration * glow).r;
#       float b = texture(tex, uv + offset - edge_normal * aberration * glow).b;
#       refracted.r = r;
#       refracted.b = b;
#
#       // Mix original with refracted
#       vec3 finalColor = mix(base.rgb, refracted.rgb, glow * 0.5);
#
#       // Add edge highlight (light catching the glass edge)
#       float highlight = glow * 0.15;
#       finalColor += vec3(highlight);
#
#       // Subtle shadow on opposite edge for depth
#       float shadow_side = dot(edge_normal, vec2(0.707, 0.707));
#       float shadow = glow * max(0.0, -shadow_side) * 0.1;
#       finalColor -= vec3(shadow);
#
#       fragColor = vec4(finalColor, base.a);
#     }
#   '';
# in
# {
#   wayland.windowManager.hyprland.settings = {
#     decoration = {
#       rounding = 30;
#       active_opacity = 1.0;
#       inactive_opacity = 1.0;
#
#       blur = {
#         enabled = true;
#         size = 4;
#         passes = 3;
#         vibrancy = 0;
#       };
#
#       # Per-window shaders
#       screen_shader = "${glassShader}";
#     };
#
#     # Optional: Window-specific rules for different shader effects
#     windowrulev2 = [
#       # You can apply different shaders per window class if needed
#       # "shader,${glassShader},class:^(kitty)$"
#     ];
#   };
# }
#
#
{ pkgs, ... }:

let
  glassShader = pkgs.writeText "window_edge_glass.frag" ''
    #version 330
    in vec2 texcoord;
    out vec4 fragColor;
    uniform sampler2D tex;

    void main() {
      // Normalized UV
      vec2 uv = texcoord;
      vec4 base = texture(tex, uv);

      // Distance to nearest edge (normalized 0–1)
      vec2 edge_dist = min(uv, 1.0 - uv);
      float edge = min(edge_dist.x, edge_dist.y);

      // Smooth falloff near edges for glow effect
      float edge_width = 0.08;
      float glow = smoothstep(edge_width, 0.0, edge);

      // Edge normal for refraction direction (points inward)
      vec2 center = vec2(0.5, 0.5);
      vec2 edge_normal = normalize(center - uv + 0.0001);

      // Refraction-style distortion
      vec2 offset = edge_normal * glow * 0.006;
      vec4 refracted = texture(tex, uv + offset);

      // Chromatic aberration for glass dispersion
      float aberration = 0.003;
      float r = texture(tex, uv + offset + edge_normal * aberration * glow).r;
      float b = texture(tex, uv + offset - edge_normal * aberration * glow).b;
      refracted.r = r;
      refracted.b = b;

      // Blend refracted and base color
      vec3 finalColor = mix(base.rgb, refracted.rgb, glow * 0.5);

      // Add bright edge highlight
      float highlight = glow * 0.18;
      finalColor += vec3(highlight);

      // Subtle dark edge on opposite side for depth
      float shadow_side = dot(edge_normal, vec2(0.707, 0.707));
      float shadow = glow * max(0.0, -shadow_side) * 0.12;
      finalColor -= vec3(shadow);

      fragColor = vec4(finalColor, base.a);
    }
  '';
in
{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 30;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      blur = {
        enabled = true;
        size = 4;
        passes = 3;
        vibrancy = 0;
      };

      # Apply per-window edge shader
      active_shader = "${glassShader}";
      inactive_shader = "${glassShader}";
    };

    windowrulev2 = [
      # Example: apply shader only to terminals
      # "shader,${glassShader},class:^(kitty)$"
    ];
  };
}
