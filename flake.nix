{
  description = "GalliaBelgicaSystems website — Markdown to static HTML";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "website-shell";

          buildInputs = [
            pkgs.pandoc
            pkgs.gnumake
            pkgs.python3
            pkgs.git
          ];
        };
      }
    );
}
