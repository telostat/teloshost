let
  ## Declare the name:
  name = "teloshost";

  ## Import niv sources:
  sources = import ./sources.nix;

  ## Import telosnix:
  telosnix = import sources.telosnix { };

  ## Import niv nixpkgs:
  pkgs = import telosnix.pkgs-sources.unstable { };

  ## Choose the Python package set:
  python-with-packages = pkgs.python3.withPackages (p: with p; [
    ## For Python Scripts:
    jinja2
    black
    isort
  ]);

  ## Declare release  scripts:
  release = pkgs.writeShellScriptBin "release" (builtins.readFile ../release.sh);

  ## Get the devshell tool:
  devshell = telosnix.tools.devshell {
    name = "teloshost";
    quickstart = ./guide/src/quickstart.md;
    guide = ./guide;
    src = ../.;
  };

  shellConfig = {
    buildInputs = [
      python-with-packages

      ## Ansible Related:
      pkgs.ansible
      pkgs.ansible-language-server
      pkgs.ansible-lint
      pkgs.git-chglog

      release
      devshell
    ];
    shellHook = ''
      PYTHONPATH=${python-with-packages}/${python-with-packages.sitePackages}

      ## Show devshell welcome message:
      devsh welcome
    '';

  };

  ## Create a development shell:
  shell = pkgs.mkShell shellConfig;
in
{
  pkgs = pkgs;
  shell = shell;
}
