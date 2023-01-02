let
  sources = import ./nix/sources.nix { };
  pkgs = import sources.nixpkgs { };

  python = pkgs.python3;
  python-with-packages = python.withPackages (p: with p; [
    ## For Python Scripts:
    jinja2
    black
    isort
  ]);

  ## Get ansi command:
  ansi = import (fetchTarball https://github.com/telostat/nix-print-ansi/archive/main.tar.gz) { };

  ## Create scripts:
  release = pkgs.writeShellScriptBin "release" (builtins.readFile ./release.sh);
in
pkgs.mkShell {
  buildInputs = [
    python-with-packages

    ## Ansible Related:
    pkgs.ansible
    pkgs.ansible-language-server
    pkgs.ansible-lint
    pkgs.git-chglog

    ansi
    release
  ];
  shellHook = ''
    PYTHONPATH=${python-with-packages}/${python-with-packages.sitePackages}

    echo
    ansi --yellow --underline "Available Commands"
    echo
    ansi --yellow "release"
  '';
}
