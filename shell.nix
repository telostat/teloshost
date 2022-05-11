{ pkgs ? import <nixpkgs> {} }:

let
  python = pkgs.python3;
  python-with-packages = python.withPackages (p: with p; [
    jinja2
    black
    isort
  ]);
in
pkgs.mkShell {
  buildInputs = [
    python-with-packages
  ];
  shellHook = ''
    PYTHONPATH=${python-with-packages}/${python-with-packages.sitePackages}
  '';
}