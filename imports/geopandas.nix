{pkgs, ... }: {
    environment.systemPackages = with pkgs; [
    python3Packages.geopandas
    python3Packages.matplotlib
    python-launcher
    python3Packages.pandas
 #   python311Packages.pint-pandas
    
  ];
}
