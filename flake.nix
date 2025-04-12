{
  description = "NixOS System configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  inputs.simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/master";
  inputs.sops-nix.url = "github:Mic92/sops-nix";
  inputs.nix-minecraft.url = "github:Infinidoge/nix-minecraft";

  outputs = { self, nixpkgs, simple-nixos-mailserver, sops-nix }@inputs:
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
        specialArgs = {
          inherit system;
          inherit inputs;
        };

        modules = [
          ./hosts/vps/configuration.nix
          ./modules/services/timetoplay-minecraft-server.nix
        ];
      };
    };
  };
}
