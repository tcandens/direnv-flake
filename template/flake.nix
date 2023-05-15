{
  description = "Elixir development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }: (
    let pkgs = import nixpkgs {};
    in with pkgs; rec {
      devShell = buildEnv {
        name = "devshell";
        paths = [
# Your dependencies here
        ];
      };
    }
  );
}
