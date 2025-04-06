{
  description = "NixOS System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-24.04";
  };

  outputs = { self, nixpkgs, simple-nixos-mailserver }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };

  in
  {
    nixosConfigurations = {
      vps = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };

        modules = [
          ./nixos/configuration.nix
          ./nixos/hardware-configuration.nix
          simple-nixos-mailserver.nixosModule
          {
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
        hashedPasswordFile = "/run/keys/info-piontekfamily-passwordhash";
        aliases = [
          "postmaster@piontekfamily.de"
          "abuse@piontekfamily.de"
          "security@piontekfamily.de"
        ];
      };
      "maximilian@piontekfamily.de" = {
        hashedPasswordFile = "/run/keys/maximilian-piontekfamily-passwordhash";
        aliasesRegexp = [
          "/^maximilian\\..*@piontekfamily\\.de$/"
        ];
      };
      "info@apelma.de" = {
        hashedPasswordFile = "/run/keys/info-apelma-passwordhash";
        aliases = [
          "@apelma.de"
          "@maximilian-apel.de"
          "@ryanfl.de"
        ];
      };
      "automation@piontekfamily.de" = {
        hashedPasswordFile = "/run/keys/automation-piontekfamily-passwordhash";
        aliasesRegexp = [
          "/^automation\\..*@piontekfamily\\.de$/"
        ];
      };
    };

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    certificateScheme = "acme-nginx";
            };
          }
        ];
      };
    };
  };
}
