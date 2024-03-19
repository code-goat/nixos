{pkgs, ... }: {
  services = {
     syncthing = {
         enable = true;
         user = "common";
         dataDir = "/home/common/Documents";    # Default folder for new synced folders
         configDir = "/home/common/.config/syncthing";   # Folder for Syncthing's settings and keys
     };
  };
}
