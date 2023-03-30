# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Enables Flakes Support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "charlemagne"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall.checkReversePath = "loose";

  # Set your time zone.
  time.timeZone = "America/New_York";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Setup display configuration
  services.xserver.xrandrHeads = [ "HDMI-0" "DP-5" ];

  # Enable NVIDIA Drivers for X11
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl.enable = true;

  hardware.steam-hardware.enable = true;

  hardware.openrazer = {
    users = [ "russjr08" ];
    enable = true;

  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
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

  # Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # Wireguard VPN
  networking.wireguard.enable = true;

  # Enable Podman for containers
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };

  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.russjr08 = {
    initialPassword = "SecurePassword!11";
    isNormalUser = true;
    description = "Russell Richardson";
    extraGroups = [ "networkmanager" "wheel" "podman" "plugdev" "openrazer" ];
    packages = with pkgs; [
      # General internet tools
      firefox
      thunderbird

      # Docker / virtualization
      podman-compose

      # Gnome related packages
      gnome.gnome-tweaks

      # Etc
      xclip
      cantarell-fonts
      btop
      neofetch
      libsecret
      alacritty

      # Development related packages
      cargo
      rustup
      gcc

      adoptopenjdk-icedtea-web
    ];
  };

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  # Enable Yubikey Authentication
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  # Enables the "Please touch the device" on authentication attempts via Yubikey
  security.pam.u2f.cue = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.git.enable = true;

  programs.gnupg.agent.pinentryFlavor = "gnome3";

  # Non-noisy audio
  programs.noisetorch.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    gnupg
    pinentry
    pinentry-gnome
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
    corefonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "22.11"; # Did you read the comment?

}
