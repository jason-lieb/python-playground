{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "python-playground";
          buildInputs = [
            pkgs.python3
            pkgs.python3Packages.pip
          ];
          shellHook = ''
            python -m venv .venv
            source .venv/bin/activate
            pip install -r requirements.txt
          '';
        };
      }
    );
}
