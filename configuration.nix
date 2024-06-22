{ config, pkgs, inputs, ... }:
 
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];
 
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
  networking.hostName = "nixos"; # Define your hostname.
 
  # Enable networking
  networking.networkmanager.enable = true;
 
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
 
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.excludePackages = [ pkgs.xterm ];
 
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
 
  # Setup user
  users.users.cabrams = {
    isNormalUser = true;
    description = "Caleb Abrams";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
 
  services.xserver = {
    enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;
 
  home-manager = {
      extraSpecialArgs = { inherit inputs; };
      users = {
        "cabrams" = import ./home.nix;
      };
  };
 
  programs.fish.enable = true;
  users.users.cabrams.shell = pkgs.fish;
 
  # Allows discord installation
  nixpkgs.config.allowUnfree = true;
 
  environment.systemPackages = with pkgs; [
        firefox
        discord
        wezterm
	redis
  ];
 
  system.stateVersion = "24.05";
}
