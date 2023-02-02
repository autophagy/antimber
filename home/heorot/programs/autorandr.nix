_:

{
  programs.autorandr = {
    profiles = {
      default = {
        config = {
          "eDP-1" = {
            enable = true;
            mode = "1920x1200";
            primary = true;
            position = "0x0";
            rate = "60.00";
          };
        };
        fingerprint = {
          "eDP-1" = "00ffffffffffff0006af91d200000000161e0104a51e137803e9eca854499f230e525a00000001010101010101010101010101010101fa3c80b870b0244010103e002dbc10000018000000fd00303c4b4b10010a202020202020000000fe0041554f0a202020202020202020000000fe004231343055414e30322e31200a00d2";
        };
      };
    };
  };
}
