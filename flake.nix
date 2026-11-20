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
    # Define the systems you want to support
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    # A helper function to generate outputs for each system
    # It imports nixpkgs for the system and passes the resulting 'pkgs' to the function 'f'
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
          rust-analyzer
          ast-grep
          prettier
          black
          alejandra
          rustfmt
          python313Packages.python-lsp-server
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
        # Define the default package for this system
        default =
          (inputs.wrappers.wrappers.neovim.wrap {
            inherit pkgs;
            env = {
              "CONFIG_ROOT" = "/home/waltz/Projects/nvim";
              "NVIM_APPNAME" = "nvim-waltz-remote";
            };
            runtimePkgs = pkgList;
            settings.config_directory = "/home/waltz/Projects/nvim";
          }).overrideAttrs (old: {
            postFixup =
              (old.postFixup or "")
              + ''
                if [ -e "$out/share/applications/nvim.desktop" ]; then
                  rm -f "$out/share/applications/nvim.desktop"
                  rmdir --ignore-fail-on-non-empty "$out/share/applications" "$out/share" 2>/dev/null || true
                fi
              '';
          });
      }
    );
  };
}
