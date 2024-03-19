{pkgs, ... }: {
   # //SYSTEM PACKAGES
    # To search, run: $ nix search wget
    environment.systemPackages = with pkgs; [
	  atuin
	  appimage-run
	  bcachefs-tools
      bitwarden
      brave
      brlaser
      brscan4
      btrfs-progs
	  bottom
      busybox
      cmake
      croc
      corefonts
      cpufetch
      davinci-resolve
      direnv
      distrobox
	  element-desktop
	  fastfetch
     fd
      ffmpeg
      filelight
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      fzf
      fishPlugins.grc
      grc
	   gh
      gimp
      git
      gitui
      github-desktop
      gittyup
      gnupg
      gparted
      gnumake
      htop
      hugo
      inxi
      lshw
      libsForQt5.audiotube
      libsForQt5.skanlite
      libsForQt5.discover
      libsForQt5.packagekit-qt
      libportal-qt5
      kdeconnect
      magic-wormhole
      mattermost-desktop
      micro
      neofetch
      neovim
      vimPlugins.nvchad
      nfs-utils
      nicotine-plus
      obsidian
      obs-studio
      onefetch
      #ollama
      plank
      python3Full
      riseup-vpn
      rpi-imager
	  rustdesk
      signal-desktop
      starship
      syncthing-tray
	  testdisk
      timeshift
      transmission-qt
      trayscale
      tldr
      unzip
      virt-manager
      #vimPlugins.LazyVim
	  #vim
      vlc
      #vscodium-fhs
      vulnix
      vscodium
       (vscode-with-extensions.override {
         vscode = vscodium;
         vscodeExtensions = with vscode-extensions; [
             antyos.openscad
              jnoortheen.nix-ide
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
         ];
        })
      wayland  
      wget
	  wl-clipboard
	  wl-clipboard-x11
	  xfce.xfce4-pulseaudio-plugin
      xfce.xfce4-whiskermenu-plugin
      #xfce.xfwm4-themes
      zellij
      zsh
      zsh-powerlevel10k
     ]; 
}