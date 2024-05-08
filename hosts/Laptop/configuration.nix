# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, outputs, pkgs, pkgs-unstable, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
			../../homes/hyprland.nix
			../../homes/waybar.nix
      ../../modules/rclone-gdrive.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
  	enable = true;
  	device = "nodev"; 
  	efiSupport = true;
	efiInstallAsRemovable = true;
	useOSProber = true;
	};

  networking.hostName = "Laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.flatpak.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement = {
			enable = false;
			finegrained = false;
		};
		open = false;
		nvidiaSettings = true;
		prime = {
			sync.enable = true;
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};
		#package = config.boot.kernelPackages.nvidiaPackages.stable;
	};

	boot.initrd.kernelModules = [ "nvidia" ];
	boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  # Enable the X11 windowing system.
  # Enable the KDE Plasma Desktop Environment.
  # Configure keymap in X11
  services.xserver = {
		videoDrivers = ["nvidia"];
  	enable = true;
		layout = "us";
		xkbVariant = "";
		desktopManager = {
			wallpaper.mode = "center";
			# plasma5.enable = true;
		};
  	displayManager = {
			sddm = {
				enable = true;
				wayland.enable = true;
				theme = "${import ../../homes/sddm/sddm-theme.nix {inherit pkgs; }}";
			};
		};
	};

	services.gnome.gnome-keyring.enable = true;
	security.pam.services.sddm.enableGnomeKeyring = true;

	programs.hyprland = {
		enable = true;
		nvidiaPatches = true;
		xwayland.enable = true;
	};

	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tosa = {
    isNormalUser = true;
    description = "Tom Sander";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs pkgs-unstable; };
    users = {
      "tosa" = import ./home.nix;
    };
  };

  environment.sessionVariables = {
		FLAKE = "/etc/nixos";
	};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = 
     (with pkgs; [
     	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     	wget
     	neovim
     	git
     	obsidian
     	discord
      neofetch
      rclone
      kate
      steam-run
      docker
      gns3-gui
      gns3-server
      inetutils
			jetbrains.webstorm
			wireshark
			brightnessctl
			mangohud
			lutris
			wineWowPackages.stable
     ])

     ++

     (with pkgs-unstable; [
      nh
     	warp-terminal
      protonvpn-gui
			google-chrome
     ]);

  fonts.packages = with pkgs; [
  	(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
