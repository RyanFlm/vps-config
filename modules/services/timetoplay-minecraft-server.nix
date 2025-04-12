{config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  inputs.nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.timetoplay = {
      enable = true;

      jvmOpts = "-Xms512M -Xmx2935M";

      package = pkgs.fabricServers.fabric-1_21_4.override {
        loaderVersion = "0.16.12";
      };

      serverProperties = {
        sync-chunk-writes = false;
        max-chained-neighbor-updates = 10000;
        simulation-distance = 8;
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
            Moonrise = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/KOHu7RCS/versions/6Dgh9jQx/Moonrise-Fabric-0.2.0-beta.9%2Bac0c7de.jar";
              sha256 = "6d1e433478e904f3cdd7f49e8d8b51011696f61d8e03e7ef28451bb42130459b";
            };
            FerriteCore = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/IPM0JlHd/ferritecore-7.1.1-fabric.jar";
              sha256 = "0dd5e9203552024e38e73a0f5b46a82eb66f0318b23289c6842b268663274a79";
            };
            Krypton = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar";
              sha256 = "94f195819b24e5da64effdc9da15cdd84836cc75e8ff0fd098bab6bc2f49e3fe";
            };
            Noisium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/9NHdQfkN/noisium-fabric-2.5.0%2Bmc1.21.4.jar";
              sha256 = "26649b7c5dc80da0b50627d1f1668a142a5a9ba9c7941590cd5af20d1e96beda";
            };
            RecipeCooldown = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/7LEWYKTV/versions/oe5KEgWu/RecipeCooldown-1.0.0.jar";
              sha256 = "44d18ff65f42d7abc3103992e0611b8941ba0e8affdb65c7ee63d5ac230144d3";
            };
            FabricLanguageKotlin = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/E4WyjCxJ/fabric-language-kotlin-1.13.2%2Bkotlin.2.1.20.jar";
              sha256 = "b316334e4190b63af42c599c13be14c46a58d0b7d93c53e06249c9ec29b22933";
            };
            Ledger = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/LVN9ygNV/versions/rTQMkMmp/ledger-1.3.7.jar";
              sha256 = "ccf5c908e71d707431a7d035736b114fc4331f3e9c8f7ba9e34d5d68d8c72afd";
            };
            ViewDistanceFix = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/nxrXbh5K/versions/JHg6ZYop/viewdistancefix-fabric-1.21.4-1.0.2.jar";
              sha256 = "6564a12a4f8104c5889c08aa7a7ec85fbef93a948a5d3103c3ab04a43510cfd0";
            };
            DisablePortalChecks = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uOzKOGGt/versions/zW17oIr0/disableportalchecks-1.0.0.jar";
              sha256 = "80489485902dd28a43a54a7f29b979766a01e0f4e68ebfe915627fb36c1905ff";
            };
          }
        );
      };
    };
  };
}
