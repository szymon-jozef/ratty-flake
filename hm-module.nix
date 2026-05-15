flakeSelf:

{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.ratty;
  fmt = pkgs.formats.toml { };
in
{
  options.programs.ratty = {
    enable = lib.mkEnableOption "ratty terminal emulator";

    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = flakeSelf.packages.${pkgs.system}.default;
      description = "The ratty package to use.";
    };

    config = {
      window = {
        width = lib.mkOption {
          type = lib.types.int;
          default = 960;
        };
        height = lib.mkOption {
          type = lib.types.int;
          default = 620;
        };
        scale_factor = lib.mkOption {
          type = lib.types.float;
          default = 1.0;
        };
        opacity = lib.mkOption {
          type = lib.types.float;
          default = 0.8;
        };
      };

      terminal = {
        default_cols = lib.mkOption {
          type = lib.types.int;
          default = 104;
        };
        default_rows = lib.mkOption {
          type = lib.types.int;
          default = 32;
        };
        scrollback = lib.mkOption {
          type = lib.types.int;
          default = 2000;
        };
      };

      env = {
        TERM = lib.mkOption {
          type = lib.types.str;
          default = "xterm-256color";
        };
      };

      font = {
        family = lib.mkOption {
          type = lib.types.str;
          default = "DejaVu Sans Mono";
        };
        style = lib.mkOption {
          type = lib.types.str;
          default = "Regular";
        };
        size = lib.mkOption {
          type = lib.types.int;
          default = 18;
        };
      };

      cursor = {
        model = {
          path = lib.mkOption {
            type = lib.types.str;
            default = "CairoSpinyMouse.obj";
          };
          scale_factor = lib.mkOption {
            type = lib.types.float;
            default = 6.0;
          };
          brightness = lib.mkOption {
            type = lib.types.float;
            default = 0.5;
          };
          x_offset = lib.mkOption {
            type = lib.types.float;
            default = 0.5;
          };
          plane_offset = lib.mkOption {
            type = lib.types.float;
            default = 18.0;
          };
          visible = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
        };

        animation = {
          spin_speed = lib.mkOption {
            type = lib.types.float;
            default = 1.4;
          };
          bob_speed = lib.mkOption {
            type = lib.types.float;
            default = 2.2;
          };
          bob_amplitude = lib.mkOption {
            type = lib.types.float;
            default = 0.08;
          };
        };
      };

      bindings.keys = lib.mkOption {
        type = lib.types.listOf (
          lib.types.submodule {
            options = {
              key = lib.mkOption {
                type = lib.types.str;
                description = "Key";
              };
              "with" = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Modifier key";
              };
              action = lib.mkOption {
                type = lib.types.str;
                description = "Action";
              };
            };
          }
        );
        default = [
          {
            key = "C";
            "with" = "Control | alt";
            action = "Copy";
          }
          {
            key = "V";
            "with" = "Control | alt";
            action = "Paste";
          }
          {
            key = "PageUp";
            "with" = "alt";
            action = "ScrollPageUp";
          }
          {
            key = "PageDown";
            "with" = "alt";
            action = "ScrollPageDown";
          }
          {
            key = "Up";
            "with" = "alt";
            action = "ScrollUp";
          }
          {
            key = "Down";
            "with" = "alt";
            action = "ScrollDown";
          }
          {
            key = "Equal";
            "with" = "Control";
            action = "IncreaseFontSize";
          }
          {
            key = "Minus";
            "with" = "Control";
            action = "DecreaseFontSize";
          }
          {
            key = "Digit0";
            "with" = "Control | alt";
            action = "ResetFontSize";
          }
          {
            key = "Enter";
            "with" = "Control | alt";
            action = "Toggle3DMode";
          }
          {
            key = "M";
            "with" = "Control | alt";
            action = "ToggleMobiusMode";
          }
          {
            key = "Up";
            "with" = "Control | alt";
            action = "IncreaseWarp";
          }
          {
            key = "Down";
            "with" = "Control | alt";
            action = "DecreaseWarp";
          }
        ];
      };

      theme = {
        foreground = lib.mkOption {
          type = lib.types.str;
          default = "#dcd7ba";
        };
        background = lib.mkOption {
          type = lib.types.str;
          default = "#1f1f28";
        };
        cursor = lib.mkOption {
          type = lib.types.str;
          default = "#7e9cd8";
        };

        normal = {
          black = lib.mkOption {
            type = lib.types.str;
            default = "#000000";
          };
          red = lib.mkOption {
            type = lib.types.str;
            default = "#cd3131";
          };
          green = lib.mkOption {
            type = lib.types.str;
            default = "#0dbc79";
          };
          yellow = lib.mkOption {
            type = lib.types.str;
            default = "#e5e510";
          };
          blue = lib.mkOption {
            type = lib.types.str;
            default = "#2472c8";
          };
          magenta = lib.mkOption {
            type = lib.types.str;
            default = "#bc3fbc";
          };
          cyan = lib.mkOption {
            type = lib.types.str;
            default = "#11a8cd";
          };
          white = lib.mkOption {
            type = lib.types.str;
            default = "#e5e5e5";
          };
        };

        bright = {
          black = lib.mkOption {
            type = lib.types.str;
            default = "#666666";
          };
          red = lib.mkOption {
            type = lib.types.str;
            default = "#f14c4c";
          };
          green = lib.mkOption {
            type = lib.types.str;
            default = "#23d18b";
          };
          yellow = lib.mkOption {
            type = lib.types.str;
            default = "#f5f543";
          };
          blue = lib.mkOption {
            type = lib.types.str;
            default = "#3b8eea";
          };
          magenta = lib.mkOption {
            type = lib.types.str;
            default = "#d670d6";
          };
          cyan = lib.mkOption {
            type = lib.types.str;
            default = "#29b8db";
          };
          white = lib.mkOption {
            type = lib.types.str;
            default = "#ffffff";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.optional (cfg.package != null) cfg.package;
    xdg.configFile."ratty/config.toml".source = fmt.generate "ratty.toml" cfg.config;
  };
}
