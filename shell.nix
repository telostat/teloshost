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
in
pkgs.mkShell {
  buildInputs = [
    python-with-packages

    ## Ansible Related:
    pkgs.ansible
    pkgs.ansible-language-server
    pkgs.ansible-lint
    pkgs.git-chglog
  ];
  shellHook = ''
    PYTHONPATH=${python-with-packages}/${python-with-packages.sitePackages}
  '';
}
