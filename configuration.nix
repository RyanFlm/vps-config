# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (builtins.fetchTarball {
        url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-24.05/nixos-mailserver-nixos-24.05.tar.gz";
        sha256 = "0clvw4622mqzk1aqw1qn6shl9pai097q62mq1ibzscnjayhp278b";
      })
    ];

  boot.loader.systemd-boot.enable = true;
  
  
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maximilian = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDK1m6EeZSN/Gl1OadAOqplMEHiC3+LbnbmlkWSti2dVNiuyDRA4no8ojAH2e2E7HooaFyxfKvLil4RJthNTuEUgp8FBlf01Oy/XU60rclbQTD92ioshtDP0BzWXocErpYKatEWJrX3YMloXa0x2TAGC+rrs9s52yy+Hmr/GJfaXl3lZWktl94NmfOsINnbd0hYzi7x2rdUVWDJXDoCbYPV3xYSbf2JYP9haxCHQy+u1HMtyGRiCJ4GUwj48oMjSoNEw6xHf8zdvFH7Nz8wtqHSUZOEsYGJe7y8rGu/H3U/KTbQZ3Lmk+5iUKpje13iVnxts47dFKyDHY4z1d5hrg9mU2vBgh72LlRjV6VvDEA53QpKSZtjSM/fWmWVRTVwvQJB9niGLuEqCrlGwWPfp34+7TexsmsMzpXMSXusu4Duqf1nFG1eFK6WCdx7xhAjSJlNRcM/oOUNB1xdN6G+UFOC0PE3UtJN147vUXylYc80nnrOngxdIgMe1N5qJy19tFk= maxim"
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
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
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "no";
  };

  mailserver = {
    enable = true;
    fqdn = "mail.piontekfamily.de";
    domains = ["piontekfamily.de"];

    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "info@piontekfamily.de" = {
        hashedPasswordFile = "/run/keys/info-passwordhash";
        aliases = [
          "postmaster@piontekfamily.de"
          "abuse@piontekfamily.de"
          "security@piontekfamily.de"
        ];
      };
    };

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    certificateScheme = "acme-nginx";
  };
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "security@piontekfamily.de";

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
    };
  };

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 80];
    # allowedUDPPorts = [ ... ];
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
