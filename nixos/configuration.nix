# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.simple-nixos-mailserver.nixosModule
  ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
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

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.fabric = {
      enable = true;

      package = pkgs.fabricServers.fabric-1_21_4.override {
        loaderVersion = "0.16.12";
      };

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            AppleSkin = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/VfjnbBAT/appleskin-fabric-mc1.21.5-3.0.6.jar";
              sha256 = "e6fe03339204f887e295701998df4b116f92ea183394156467670ab1aaf6efb3";
            };
            Cardinal-Components-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/K01OU20C/versions/iKXDXx3i/cardinal-components-api-6.2.2.jar";
              sha256 = "2e1956d594827767166c27aaddc925ed33aaa25b49afb29765d9ec3122e1865d";
            };
            Carry-On = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/joEfVgkn/versions/yGvNZNhB/carryon-fabric-1.21.4-2.3.0.22.jar";
              sha256 = "71aa509c619d4c1f38529f1787540fb07e02b9ac3162d5565a1049373a84f595";
            };
            Cloth-Config = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/9s6osm5g/versions/TJ6o2sr4/cloth-config-17.0.144-fabric.jar";
              sha256 = "1fda0c4a89d4f075e51b3eb5570a4912870656d252d806ea3091d2bbc06781ea";
            };
            Clumps = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Wnxd13zP/versions/1ZHtT6Xo/Clumps-fabric-1.21.4-22.0.0.1.jar";
              sha256 = "67d0ef6753c2874f22c41e354a0576dcd9128f1357cb153784d617630c7e5fe8";
            };
            CreativeCore = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/OsZiaDHq/versions/ixu9AXyq/CreativeCore_FABRIC_v2.12.35_mc1.21.4.jar";
              sha256 = "a3bb0e77da7e752efb240f1641a8bf26396bf1c604b733be993fdc197de1acac";
            };
            Chunky = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fALzjamp/versions/VkAgASL1/Chunky-Fabric-1.4.27.jar";
              sha256 = "03c90a70b233416bd96738949be909d1ecadac743f7c1559435f2e41737d41fd";
            };
            Distant-Horizons = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uCdwusMi/versions/94McsAoL/DistantHorizons-neoforge-fabric-2.3.2-b-1.21.4.jar";
              sha256 = "b9fffc1cd99e63da112c7caa4645581a2d586a917e5b167285788c9eac520b32";
            };
            Fabric-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/bQZpGIz0/fabric-api-0.119.2%2B1.21.4.jar";
              sha256 = "0a7e37d1577217d764bc4a41fd144961ce6e4db1ef5e2b40ba5f280d4119ad0a";
            };
            Incendium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/ZVzW5oNS/versions/7mVvV9Th/Incendium_1.21.x_v5.4.4.jar";
              sha256 = "285a4f69fe2391f2175f7fc9316d727a39c79bdd214923c59284d569bce656f4";
            };
            Lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/u8pHPXJl/lithium-fabric-0.15.3%2Bmc1.21.4.jar";
              sha256 = "153891e8d6988fedffa5098851a725a137c3e5ca04a89a8df409feb313623eb4";
            };
            Lithostitched = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/XaDC71GB/versions/n1TiLJEh/lithostitched-fabric-1.21.4-1.4.5.jar";
              sha256 = "c802b99ed003818dad3268955faf73df58354f69a834e6fae5896070f23c80f1";
            };
            MidnightLib = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/codAaoxh/versions/owfXImvq/midnightlib-1.7.1-fabric%2B1.21.4.jar";
              sha256 = "ea8d881ca18158c521e5b9acaea1954d502f7ce3ff2046b75e1d7e1f5f5d1e5e";
            };
            Nullscape = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/LPjGiSO4/versions/dHJAVX8s/Nullscape_1.21.x_v1.2.10.jar";
              sha256 = "0da47456ff3ea3835df01d78a828edbafaf20dcfed7d77fa36d8354f8766cace";
            };
            Placeholder-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/eXts2L7r/versions/eeN3FuMY/placeholder-api-2.5.2%2B1.21.3.jar";
              sha256 = "d09cb209dac7e63d9b73cdf7da6f35da164720f0641c2d95ca14ec978b11cd32";
            };
            Simple-Voice-Chat = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/OkKjbu1V/voicechat-fabric-1.21.4-2.5.29.jar";
              sha256 = "1f56f67f7550fa1b4e43bc871222fe108e5465828b6910083c31e08bc93e820d";
            };
            Spawn-Animations = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/zrzYrlm0/versions/4q2qDUKg/spawnanimations-v1.10-mc1.17x-1.21x-mod.jar";
              sha256 = "c5833e3bb951fc2a06ab50e4b0693f4689328dca667497fd65764ccdce5b62db";
            };
            Tectonic = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/FOOSlG8w/tectonic-fabric-1.21.4-2.4.3.jar";
              sha256 = "a95db44987fb09ca7604e5bd2986e217eb535d38322257893c9dc334a7e80a04";
            };
            Terralith = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/MuJMtPGQ/Terralith_1.21.x_v2.5.8.jar";
              sha256 = "00333a130ac38b7b9ca93700098d5e02e0612bdc2d3522aada2f36e5600621bf";
            };
            Travelers-Backpack = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/rlloIFEV/versions/EmcgYZ2P/travelersbackpack-fabric-1.21.4-10.4.9.jar";
              sha256 = "4379e22569d95e8fdf429789bb6c31e813149c0e4c6f35b60baf631ee430902a";
            };
            YetAnotherConfigLib = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/1eAoo2KR/versions/XeXZrziK/yet_another_config_lib_v3-3.6.6%2B1.21.4-fabric.jar";
              sha256 = "740d43a43f7dfae4a7debe2fd96a93a6c49f6b68eba4e89ef1de8706ce404fad";
            };
          }
        );
      };
    };
  };

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
