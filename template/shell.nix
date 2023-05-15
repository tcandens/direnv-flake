{ pkgs ? (import <nixpkgs> {}).pkgs }:

let 
  flake = builtins.getFlake (builtins.toString ./.);
in with flake;

pkgs.mkShell {
  buildInputs = [ flake.devShell ];
}
