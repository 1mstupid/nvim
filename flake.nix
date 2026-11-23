{
  description = "Neovim with LSP dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = f:
      nixpkgs.lib.genAttrs supportedSystems (
        system: f (import nixpkgs {inherit system;})
      );
  in {
    packages = forAllSystems (
      pkgs: let
        pkgList = with pkgs; [
          # LSPs
          lua-language-server
          vscode-langservers-extracted
          emmet-language-server
          rust-analyzer
          ast-grep
          prettier
          black
          alejandra
          rustfmt
          python313Packages.python-lsp-server
          stylua
          nixd

          # Other tools
          lua5_1
          tree-sitter
          ripgrep
          gcc
          cargo
          fzf
          gnumake
          imagemagick
          luarocks
        ];

        neovim = inputs.wrappers.wrappers.neovim.wrap {
          inherit pkgs;

          env = {
            CONFIG_ROOT = "/home/waltz/Projects/nvim";
            NVIM_APPNAME = "nvim-waltz-remote";
          };

          runtimePkgs = pkgList;
          settings.config_directory = "/home/waltz/Projects/nvim";
        };

        desktopItem = pkgs.makeDesktopItem {
          name = "nvim-waltz-remote";
          desktopName = "Neovim";
          genericName = "Text Editor";
          comment = "Edit text files";

          exec = "${pkgs.alacritty}/bin/alacritty -e ${neovim}/bin/nvim %F";

          terminal = false;

          categories = [
            "Utility"
            "TextEditor"
            "Development"
          ];

          icon = "nvim";
          startupNotify = false;
        };
      in {
        default = neovim;
        neovim = neovim;

        nvim-desktop = pkgs.symlinkJoin {
          name = "nvim-desktop";

          paths = [
            neovim
            desktopItem
          ];
        };
      }
    );
  };
}
