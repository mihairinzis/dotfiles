{ inputs, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
#      inputs.home-manager.nixosModules.home-manager
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "rmi";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  time.timeZone = "Europe/Bucharest";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-22.3.27"
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
    xkbVariant = "";
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.mihai = {
      isNormalUser = true;
      description = "mihai";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [ qemacs git tailscale ];
    };
  };

#  home-manager = {
#    extraSpecialArgs = { inherit inputs; };
#    users = {
#      mihai = import ./home.nix;
#    };
#  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # services.openssh.enable = true;
  programs.zsh.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.tlp.enable = true;
  services.tailscale.enable = true;
  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    # always allow traffic from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];
    # allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  system.stateVersion = "23.05";
}
