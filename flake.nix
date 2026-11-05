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
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f (import nixpkgs {inherit system;}));
  in {
    # Use the helper to generate the packages attribute for every system
    packages = forAllSystems (
      pkgs: let
        pkgList = with pkgs; [
          # LSPs
          lua-language-server
          vscode-langservers-extracted
          emmet-language-server
          svelte-language-server
          rust-analyzer
          ast-grep
          prettier
          black
          alejandra
          rustfmt
          python313Packages.python-lsp-server
          typescript-language-server
          tailwindcss-language-server
          stylua
          nixd

          # other tools
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
      in {
        default = inputs.wrappers.wrappers.neovim.wrap {
          inherit pkgs;

          env = {
            CONFIG_ROOT = "${./.}";
            NVIM_APPNAME = "nvim-waltz-remote";
          };
          runtimePkgs = pkgList;
        };
        minimal = inputs.wrappers.wrappers.neovim.wrap {
          inherit pkgs;
          env = {
            "CONFIG_ROOT" = ./.;
            "NVIM_APPNAME" = "nvim-waltz-remote";
          };
          runtimePkgs = with pkgs; [
            lua5_1
            tree-sitter
            ripgrep
            gcc
            fzf
            luarocks
          ];
          settings.config_directory = ./.;
        };
      }
    );
  };
}

