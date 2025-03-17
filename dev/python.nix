{ config, pkgs, ... }:

let
  my-python-packages = ps: with ps; [
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
    # LSP
    python-lsp-server
    radian # ipython for R
  ];
in
{
  environment.systemPackages = with pkgs; [
    (python3.withPackages my-python-packages)
    uv # package manager
  ];
}
