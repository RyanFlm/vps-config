# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
    inputs.simple-nixos-mailserver.nixosModule
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/maximilian/.config/sops/age/keys.txt";

  sops.secrets."mailserver/users/automation-piontekfamily" = {};
  sops.secrets."mailserver/users/info-apelma" = {};
  sops.secrets."mailserver/users/info-piontekfamily" = {};
  sops.secrets."mailserver/users/maximilian-piontekfamily" = {};
  sops.secrets."wireguard/private-key" = {};

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;

  nixpkgs.config.allowUnfree = true;

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = "1";
    "net.ipv6.conf.all.forwarding" = "1";
  };

  networking = {
    hostName = "vps";
    domain = "piontekfamily.de";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ 51820 ];
    };
    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "ens3";
      internalInterfaces = [ "wg0" ];
    };
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = [ "10.100.0.1/24" ];
          listenPort = 51820;
          postSetup = ''
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -j MASQUERADE
          '';
          postShutdown = ''
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -j MASQUERADE
          '';
          privateKeyFile = config.sops.secrets."wireguard/private-key".path;
          peers = [
            {
              publicKey = "w+O3T05yz6siEiELqKVmQnpQP9aRn7g4QxNEo5ClsFk=";
              allowedIPs = [ "10.100.0.2/32" ];
            }
          ];
        };
      };
    };
  };

  time.timeZone = "Europe/Berlin";
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maximilian = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDK1m6EeZSN/Gl1OadAOqplMEHiC3+LbnbmlkWSti2dVNiuyDRA4no8ojAH2e2E7HooaFyxfKvLil4RJthNTuEUgp8FBlf01Oy/XU60rclbQTD92ioshtDP0BzWXocErpYKatEWJrX3YMloXa0x2TAGC+rrs9s52yy+Hmr/GJfaXl3lZWktl94NmfOsINnbd0hYzi7x2rdUVWDJXDoCbYPV3xYSbf2JYP9haxCHQy+u1HMtyGRiCJ4GUwj48oMjSoNEw6xHf8zdvFH7Nz8wtqHSUZOEsYGJe7y8rGu/H3U/KTbQZ3Lmk+5iUKpje13iVnxts47dFKyDHY4z1d5hrg9mU2vBgh72LlRjV6VvDEA53QpKSZtjSM/fWmWVRTVwvQJB9niGLuEqCrlGwWPfp34+7TexsmsMzpXMSXusu4Duqf1nFG1eFK6WCdx7xhAjSJlNRcM/oOUNB1xdN6G+UFOC0PE3UtJN147vUXylYc80nnrOngxdIgMe1N5qJy19tFk= maxim"
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    wireguard-tools
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable git to manage config
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "plex.piontekfamily.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://10.100.0.2:32400";
          proxyWebsockets = true;
        };
      };
      "home.piontekfamily.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://10.100.0.2:8123";
          proxyWebsockets = true;
        };
      };
    };
  };

  mailserver = {
    enable = true;
    fqdn = "mail.piontekfamily.de";
    domains = [
      "piontekfamily.de"
      "apelma.de"
      "maximilian-apel.de"
      "ryanfl.de"
    ];

    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "info@piontekfamily.de" = {
        hashedPasswordFile = config.sops.secrets."mailserver/users/info-piontekfamily".path;
        aliases = [
          "postmaster@piontekfamily.de"
          "abuse@piontekfamily.de"
          "security@piontekfamily.de"
        ];
      };
      "maximilian@piontekfamily.de" = {
        hashedPasswordFile = config.sops.secrets."mailserver/users/maximilian-piontekfamily".path;
        aliasesRegexp = [
          "/^maximilian\\..*@piontekfamily\\.de$/"
        ];
      };
      "info@apelma.de" = {
        hashedPasswordFile = config.sops.secrets."mailserver/users/info-apelma".path;
        aliases = [
          "@apelma.de"
          "@maximilian-apel.de"
          "@ryanfl.de"
        ];
      };
      "automation@piontekfamily.de" = {
        hashedPasswordFile = config.sops.secrets."mailserver/users/automation-piontekfamily".path;
        aliasesRegexp = [
          "/^automation\\..*@piontekfamily\\.de$/"
        ];
      };
    };

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    certificateScheme = "acme-nginx";
  };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "security@piontekfamily.de";

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;

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
