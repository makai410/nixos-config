{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nixd
      alejandra
      marksman
      tinymist
      pyright
      ruff
    ];
    settings = {
      theme = "amberwood";
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "underline";
          select = "bar";
        };
        statusline = {
          mode = {
            insert = "INSERT";
            normal = "NORMAL";
            select = "SELECT";
          };
        };
        indent-guides = {
          render = true;
          character = "╎";
          skip-levels = 1;
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
    };
    languages = {
      language-server = {
        nixd = {
          command = "nixd";
        };
        tinymist = {
          command = "tinymist";
          config.exportPdf = "onSave";
        };
        ruff = {
          command = "ruff";
          args = ["server"];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = ["nixd"];
          formatter = {
            command = "alejandra";
            args = ["--quiet"]; # Ensures clean stdin/stdout piping
          };
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = ["rust-analyzer"];
        }
        {
          name = "toml";
          auto-format = true;
          language-servers = ["taplo"];
        }
        {
          name = "typst";
          auto-format = true;
          language-servers = ["tinymist"];
          formatter.command = "typstyle";
        }
        {
          name = "markdown";
          auto-format = true;
          language-servers = ["marksman"];
          formatter = {
            command = "prettier";
            args = ["--parser" "markdown"];
          };
        }
        {
          name = "python";
          auto-format = true;
          language-servers = ["pyright" "ruff"];
        }
      ];
    };
  };
}
