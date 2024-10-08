{
  description = "A devShell example";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , rust-overlay
    , flake-utils
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rustpkg = pkgs.rust-bin.selectLatestNightlyWith (toolchain:
          toolchain.default.override {
            extensions = [ "rust-src" "rustfmt" "clippy" "rust-analyzer" ]; # rust-src for rust-analyzer
            targets = [ "x86_64-unknown-linux-gnu" ];
          });
      in
      with pkgs; {
        devShells = {
          default = mkShell {
            buildInputs = [
              openssl
              pkg-config
              eza
              fd
              rustpkg
              # youcan also rust-bin.{stable, beta, nightly}.{lastest, "2121-01-01"...}.default
              # where override {extensions = []; targets = [];}
            ];

            shellHook = ''
              alias ls=eza
              alias find=fd
            '';
          };
        };
      }
    );
}
