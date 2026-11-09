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

            # --- buildroot für SBC, Linux 6.12 mit preemtprt, glibc und bussybox --- 
            # =======================================================================
            # Build tools
              gcc
              gnumake
              binutils
              pkg-config

              # Buildroot dependencies
              bc
              bison
              flex
              gawk
              perl
              python3
              rsync
              cpio
              unzip
              file
              wget
              git
              which
              patch
              diffutils
              findutils
              gettext

              # Libraries / host tools
              ncurses
              openssl
              zlib
              libelf
              libyaml
              dtc

              # Utilities
              util-linux
              coreutils
              gnused
              gnutar
              gzip
              xz
              bzip2

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

