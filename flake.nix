{
  description = "Masterarbeit Typst-Projekt";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree=true;};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Thesis schreiben
            typst
            corefonts
          ];

          TYPST_FONT_PATHS = "${pkgs.corefonts}/share/fonts";

          shellHook = ''

            echo "========="
            echo "Typst"
            echo "========="

          '';
        };
      });
}

