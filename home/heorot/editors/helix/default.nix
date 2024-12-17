{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      bash-language-server
      rust-analyzer
      terraform-ls
      yaml-language-server
      nixfmt-rfc-style
      pyright
      ruff-lsp
      nil
    ];

    settings = {
      theme = "gruvbox";
      editor = {
        bufferline = "multiple";
        true-color = true;
        mouse = false;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        indent-guides = {
          render = true;
          character = "⸽";
          skip-levels = 1;
        };
        statusline = {
          left = [
            "mode"
            "file-name"
            "spinner"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "selections"
            "register"
            "file-type"
            "file-line-ending"
            "position"
          ];
          separator = "|";
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
      };
    };

    languages = {
      language-server = {
        rust-analyzer = {
          config = {
            checkOnSave.command = "clippy";
            cargo.features = "all";
            cargo.unsetTest = [ ];
          };
        };
        bash-language-server = {
          command = "${pkgs.bash-language-server}/bin/bash-language-server";
          args = [ "start" ];
        };
        nil = {
          command = "${pkgs.nil}/bin/nil";
        };
        pyright = {
          command = "${pkgs.pyright}/bin/pyright-langserver";
          args = [ "--stdio" ];
        };
        ruff = {
          command = "${pkgs.ruff-lsp}/bin/ruff-lsp";
        };
        elm = {
          command = "${pkgs.elmPackages.elm-language-server}/bin/elm-language-server";
        };
      };

      language = [
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "pyright"
            "ruff"
          ];
          formatter = {
            command = "sh";
            args = [
              "-c"
              "isort --profile black - | black -q -"
            ];
          };
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = [ { name = "nil"; } ];
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
        {
          name = "bash";
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
          auto-format = true;
        }
        {
          name = "elm";
          language-servers = [ "elm" ];
        }
      ];
    };
  };
}
