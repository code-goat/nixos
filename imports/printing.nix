{pkgs, ... }: {
     # Enable Printing & Scanning
        services.printing.enable = true;
        services.printing.drivers = [ pkgs.brlaser ];
    
      # Brother Printer
        hardware = {
            sane = {
              enable = true;
              brscan4 = {
                enable = true;
                netDevices = {
                  home = { model = "DCP-L2540DW"; ip = "192.168.043.109"; };
                };
              };
            };
          };
}
