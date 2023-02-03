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
      dock = {
        config = {
          "DP-3-1-6" = {
            enable = true;
            mode = "1920x1080";
            primary = true;
            position = "0x0";
            rate = "60.00";
          };
          "DP-3-1-5" = {
            enable = true;
            mode = "1920x1080";
            primary = false;
            position = "1920x0";
            rate = "60.00";
          };
        };
        fingerprint = {
          "DP-3-1-6" = "00ffffffffffff0010ac91414c385941321d0104a53c22783a4815a756529c270f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c450056502100001e000000ff00443054445453320a2020202020000000fc0044454c4c20533237313948530a000000fd00384c1e5311010a2020202020200080";
          "DP-3-1-5" = "00ffffffffffff0010acff4155393833301e0103803c2278eab9a5a356509f260e5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c450056502100001e000000ff00393447343632330a2020202020000000fc0044454c4c2053323732314e580a000000fd00304b1e5311000a202020202020011902032bf14f90050403020716010611121513141f230907078301000065030c001000681a00000101304be62a4480a0703827403020350056502100001a011d8018711c1620582c250056502100009e011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e9600565021000018000000000000000000000000f0";
        };
      };
    };
  };
}
