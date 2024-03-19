{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    buildPakages.python311
    buildPackages.python311Packages.geopandas
  ];

  # Set Python 3.11 as default Python version
  shellHook = ''
    export PYTHONPATH=${pkgs.python311Packages.geopandas}/${pkgs.python311.sitePackages}
    export PYTHONHOME=$PYTHONPATH
  '';
}
