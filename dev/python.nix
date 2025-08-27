{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

let
  my-python-packages =
    ps: with ps; [
      pandas
      epc
      sexpdata
      six
      inflect
      requests
      orjson
      paramiko
      rapidfuzz
      xdg-base-dirs
      numpy
      matplotlib
      flask
      jupyter
      ipython
      gdown
      opencv4
      pillow
      urllib3
      scipy
      urllib3
      pkgs-unstable.aider-chat
      # LSP
      python-lsp-server
      radian # ipython for R
      pip
      huggingface-hub
    ];
in
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
    ];
  };
  # https://github.com/nix-community/nix-ld?tab=readme-ov-file#my-pythonnodejsrubyinterpreter-libraries-do-not-find-the-libraries-configured-by-nix-ld
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "python" ''
      export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
      exec ${pkgs.python3}/bin/python "$@"
    '')
    (pkgs.python3.withPackages my-python-packages)
    pkgs.uv # package manager
  ];
}
