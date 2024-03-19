# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


# Research:
#   environment.variables.VARIABLE = "VALUE";

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware-acceleration.nix
      #./DesktopEnv/hyprland.nix
      ./packages-by-machine/packages-laptop.nix
      ./services/syncthing.nix
      #./services/nixvim.nix
      ./imports/geopandas.nix
      ./imports/printing.nix
      #./services/vorta.nix
    ];

  # //CUSTOM FIXES
    # Network Manager Fix	
  	  systemd.services.NetworkManager-wait-online.enable = false;

  	# CPU Governor Mode Setting
  	  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  	  
    # Slow boot, start job problem
      systemd.services.NetworkManager-wait-online.serviceConfig.Type = "oneshot";
      
	
  # //NIXOS SETTINGS

	# Nix Settings
	 nix.settings = {
	 	auto-optimise-store = true;
	 	experimental-features = [ "nix-command" "flakes" ];
	 	trusted-users = [ "root" "common" ];
	 };
    
    # Enable Automatic Garbage Collection 
      nix.gc = {
        automatic = true;
        dates = "weekly";
       options = "--delete-older-than 10d";
      };

    # Allow unfree packages
    #  nixpkgs.config.allowUnfree = true;

  # //BOOT

	# LINUX KERNEL VERSION
	  boot.kernelPackages = pkgs.linuxPackages_latest;
  
    # Bootloader
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      
    # Enable encryption module on boot
      boot.initrd.availableKernelModules = [
        "aesni_intel"
        "cryptd"
      ];
   
    # Possible GPU Hang bug fix?
      boot.kernelParams = [
      	"i915.enable_psr=1"
      ];
 
    # Setup keyfile
     # boot.initrd.secrets = {
      #"/crypto_keyfile.bin" = null;
     # };

  # //NETWORKING
  	# Enable networking
      networking.networkmanager.enable = true;
      networking.dhcpcd.wait = "background";
      
    # Firewall
  	  networking.firewall.enable = false;
      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];

	  # WoL (Wake-on-LAN) Support
	 	 powerManagement.enable = true;
     	# networking.interfaces.tailscale0.wakeOnLan.enable = true;
     	# networking.interfaces.enp2s0.wakeOnLan.enable = true;
     	 networking.hostName = "t480"; # Define Hostname

    # Enables wireless support via wpa_supplicant.
    # networking.wireless.enable = true;  

    # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
        
    # Set your time zone.
      time.timeZone = "America/Los_Angeles";
    
    # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
       };
      
  # //SERVICES

  	# Gnome-Keyring
  	  services.gnome.gnome-keyring.enable = true;
     # security.pam.services.gdm.enableGnomeKeyring = true;

  	# KDE Keyring auto unlock
  	  security.pam.services.common.enableKwallet = true;

    #GNuPG
      security.pam.services.common.gnupg.enable = true;
      
	# fwupd
	  services.fwupd.enable = true;
	  services.packagekit.enable = true;
	     
    # OpenSSH daemon.
      services.openssh.enable = true;

    # FLATPAK support
      services.flatpak.enable = true;

    # TAILSCALE support  
      services.tailscale.enable = true;

    # Usenet Support via Radarr
      services.radarr.enable = true;

  # //WINDOW MANAGEMENT
      # Enable the X11 windowing system.
        services.xserver.enable = true;
        
      # xwayland support
        programs.xwayland.enable = true;
               
      # Configure keymap in X11
        services.xserver.xkb = {
         layout = "us";
         variant = "";
         };

  # //DESKTOP ENVIRONMENT & SETTINGS

	  # Enable Hyprland Desktop Environment
	  #	programs.hyprland.enable = true;
	  	  
      # Enable the KDE Plasma Desktop Environment.
        services.xserver.displayManager.sddm.enable = true;
        services.xserver.displayManager.sddm.theme = "clairvoyance";
		#services.xserver.displayManager.gdm.enable = true;
		#services.xserver.displayManager.gdm.wayland = true;
		#services.xserver.displayManager.lightdm.enable = true;

	  # Enable Plasma Desktop Environment	
        services.desktopManager.plasma6.enable = true;
		    services.desktopManager.plasma6.enableQt5Integration = true;
        services.xserver.displayManager.defaultSession = "plasma";
      
      # Enable XFCE Desktop Environment
      #  services.xserver.desktopManager.xfce.enable = true;

      # Enable LXQT Desktop Environment
      	#services.xserver.desktopManager.lxqt.enable = true;

      # Enable Enlightenment
      	#services.xserver.desktopManager.enlightenment.enable = true;

      # Enable touchpad support (enabled default in most desktopManager).
        services.xserver.libinput.enable = true;   
             
      # Enable Bluetooth Support
        hardware.bluetooth.enable = true;
        services.blueman.enable = true;

	  # Enable DirEnv for VSCodium 
	    programs.direnv = {
   			 enable = true;
    		nix-direnv.enable = true;
		};

	  # Enable AppImage Support
	  	boot.binfmt.registrations.appimage = {
	  	  wrapInterpreterInShell = false;
	  	  interpreter = "${pkgs.appimage-run}/bin/appimage-run";
	  	  recognitionType = "magic";
	  	  offset = 0;
	  	  mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
	  	  magicOrExtension = ''\x7fELF....AI\x02'';
	  	};

  # //DRIVES & FILESYSTEMS (make external .nix file)
  	  # # Enable swap on luks
      #   boot.initrd.luks.devices."luks-ac0cfc22-6519-40f1-b251-9364814b8628".device = "/dev/disk/by-uuid/ac0cfc22-6519-40f1-b251-9364814b8628";
      #   boot.initrd.luks.devices."luks-ac0cfc22-6519-40f1-b251-9364814b8628".keyFile = "/crypto_keyfile.bin";

      # Enable 16gb Swapfile  
         swapDevices = [ {
             device = "/var/lib/swapfile";
             size = 32*1024;
           } ];
        
      # zram
        zramSwap.enable = true;

  # //FONTS
       fonts.fontDir.enable = true;
       fonts = {
          packages = with pkgs; [
             fira-code
             fira-code-symbols
             noto-fonts
             noto-fonts-cjk
             noto-fonts-emoji
             font-awesome
             source-han-sans
          (nerdfonts.override { fonts = [ "Meslo" ]; })
          ];
        fontconfig = {
          enable = true;
           defaultFonts = {
  	          monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
  	          serif = [ "Noto Serif" "Source Han Serif" ];
  	          sansSerif = [ "Noto Sans" "Source Han Sans" ];
           };
          };
        };
  
  # //VIRTUALIZATION

    # libvirt
      virtualisation.libvirtd.enable = true;
      programs.dconf.enable = true;
            
    # Podman Backend
	  virtualisation.podman.enable = true;
      virtualisation.oci-containers.backend = "podman";
      virtualisation.podman.autoPrune.enable = true;
    
    
  # //AUDIO
    # Enable sound with pipewire.
      sound.enable = true;
      hardware.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
      }; 
  
  # //USER MANAGEMENT & PKGs

  
    # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.common = {
         isNormalUser = true;
         description = "common";
         extraGroups = [ "networkmanager" "wheel" "libvirtd" "scanner" "lp" ];
		        #++ (lib.optionals ifExists [ "video" "docker" "syncthing"  ]); 
      packages = with pkgs; [
         firefox
         kate
         librewolf
         libsForQt5.yakuake
         discord
        ];
      };

      ## Define Trusted Users
      #nix.trustedUsers = [ "root" "common" ];

  # //USER PROGRAMS & SERVICES
    # User added programs services
      programs.git.enable = true;
      programs.partition-manager.enable = true;
      programs.kdeconnect.enable = true;

      # Declare fish defult
      programs.fish.enable = true;
      users.defaultUserShell = pkgs.fish;

    # zsh & powerline integration  
      programs.zsh.enable = true;

  # // ALLOW INSECURE PKGS
  #nixpkgs.config.permittedInsecurePackages = [
              #    "electron-25.9.0"
                #  "electron-19.1.9"
              #  ];

  # //MISC
   
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
       enable = true;
       enableSSHSupport = true;
    };

  # //NIXOS VERSION
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
   
    # Auto system update
    system.autoUpgrade = {
      enable = false;
    };
}

