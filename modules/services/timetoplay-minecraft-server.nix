{ config, lib, pkgs, nixpkgs, inputs, ... }:

{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  networking.firewall.allowedUDPPorts = [ 24454 ];

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
            Accessories = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/jtmvUHXj/versions/wmLc2Y7f/accessories-fabric-1.2.19-beta%2B1.21.4.jar"; "sha256" = "ffcae749238ed491dba43f36df489bbcdba957221434644c9c3f5228f988abb3"; };
            AddonsLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/cl5ec0Qm/versions/hivJlzEB/addonslib-fabric-1.21.4-1.1.jar"; "sha256" = "ff8636f8fa3efa0ca26e9a86ed5b352ec9e63b6350dd3f700924869c9e412086"; };
            Advancement_Plaques = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9NM0dXub/versions/v6oG7aah/AdvancementPlaques-1.21.4-fabric-1.6.9.jar"; "sha256" = "680e0f63039e080682bf440ff26ae5d576b164ffc2964bb2c8467cc9f6eedc71"; };
            AmbientSounds = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fM515JnW/versions/qqQs6YzG/AmbientSounds_FABRIC_v6.1.3_mc1.21.4.jar"; "sha256" = "44db029c783dfebf097ada53eaad15efd1d592aff8d76cfb77dd6051f507d9f3"; };
            AppleSkin = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/cHQjeYVS/appleskin-fabric-mc1.21.3-3.0.6.jar"; "sha256" = "f8f611746df88f1737b62a76615a366f42a331730ea16db97c52d6f5540c58ab"; };
            Architectury = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/73nlw3WM/architectury-15.0.3-fabric.jar"; "sha256" = "9e11f81ee786401a26de486a9798687559a5329fec3cd415e94fa3c3958352f3"; };
            AutoSow_Mod = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/M9J9h28D/versions/h4hMEPiu/AutoSow-1.2.0.jar"; "sha256" = "f2730a8d3d43e3bd273da55ca2634cad696a3d5ef9c0d0d4f0793137aa3da71d"; };
            Balm = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/OtvlX1P9/balm-fabric-1.21.4-21.4.28.jar"; "sha256" = "5bc2bd5fcb47a6f59b957c64829b344d9d1bd6014a5c7b8b3c6f2dd916a1a215"; };
            Benched = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/WjRy3Hb2/versions/7TGC0RAa/benched-1.2.2-fabric-mc1.21.4.jar"; "sha256" = "c831ce768d6a496d284f54965f31a4efd59bfbae11600ae13cfc877e65607ba3"; };
            BetterF3 = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/8shC1gFX/versions/729ec3Jf/BetterF3-13.0.0-Fabric-1.21.4.jar"; "sha256" = "a49a66f0e6947e4c2810ca161e622ee64ad4f3356245133f27b8f57ce922e798"; };
            BiomesOPlenty = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/HXF82T3G/versions/1hMDdKWQ/BiomesOPlenty-fabric-1.21.4-21.4.0.23.jar"; "sha256" = "9f538ae6f0e955c14c116e898289d3bfb38926037adb1e11d386410e0c5a3318"; };
            Camerapture = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9dzLWnmZ/versions/vSNha10j/Camerapture-1.10.0%2Bmc1.21.4-fabric.jar"; "sha256" = "9c14f76130668a0287de06150090edf0ee142c1b32c847c6c6f9b56c02ecc89c"; };
            Cardinal_Components_API = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/K01OU20C/versions/iKXDXx3i/cardinal-components-api-6.2.2.jar"; "sha256" = "2e1956d594827767166c27aaddc925ed33aaa25b49afb29765d9ec3122e1865d"; };
            Carry_On = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/joEfVgkn/versions/yGvNZNhB/carryon-fabric-1.21.4-2.3.0.22.jar"; "sha256" = "71aa509c619d4c1f38529f1787540fb07e02b9ac3162d5565a1049373a84f595"; };
            Chat_Heads = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Wb5oqrBJ/versions/gO3IHKSR/chat_heads-0.13.14-fabric-1.21.4.jar"; "sha256" = "d745fcc406b88b649dbe69f3520374e6daf85fdcdec7726595fb1fa2e8a1e9a5"; };
            Chisel_Refabricated = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/4KWv7wbN/versions/8gY6LyiR/chisel-fabric-2.0.0%2Bmc1.21.4.jar"; "sha256" = "927f044b1e9927395756d62b2cd9bab6bdd8239a1f5d9df20855f68f62b3667d"; };
            Cloth_Config_v17 = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9s6osm5g/versions/TJ6o2sr4/cloth-config-17.0.144-fabric.jar"; "sha256" = "1fda0c4a89d4f075e51b3eb5570a4912870656d252d806ea3091d2bbc06781ea"; };
            Clumps = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Wnxd13zP/versions/1ZHtT6Xo/Clumps-fabric-1.21.4-22.0.0.1.jar"; "sha256" = "67d0ef6753c2874f22c41e354a0576dcd9128f1357cb153784d617630c7e5fe8"; };
            Continuity = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/1IjD5062/versions/esC1Vejm/continuity-3.0.0%2B1.21.4.jar"; "sha256" = "15532119b71eb17796195a57d21289b30ada0c9e92995fbea170ca59e656e5bb"; };
            Controlling = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/xv94TkTM/versions/sLtmudOk/Controlling-fabric-1.21.4-22.0.5.jar"; "sha256" = "4e39a8456b8f0f4411cf76e22016fb12cb12fada52a3426ca6f443c5258326c4"; };
            CreativeCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/OsZiaDHq/versions/ixu9AXyq/CreativeCore_FABRIC_v2.12.35_mc1.21.4.jar"; "sha256" = "a3bb0e77da7e752efb240f1641a8bf26396bf1c604b733be993fdc197de1acac"; };
            Cryonic_Config = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/oEhQIkOs/versions/LKryysne/cryonicconfig-fabric-1.0.0%2Bmc1.21.4.jar"; "sha256" = "6929fc4dbc7c5abcf8711c7eef713955291a94c8dea8d8afda4cc85f72e5ad84"; };
            DisablePortalChecks = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uOzKOGGt/versions/zW17oIr0/disableportalchecks-1.0.0.jar"; "sha256" = "80489485902dd28a43a54a7f29b979766a01e0f4e68ebfe915627fb36c1905ff"; };
            Distant_Horizons = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uCdwusMi/versions/94McsAoL/DistantHorizons-neoforge-fabric-2.3.2-b-1.21.4.jar"; "sha256" = "b9fffc1cd99e63da112c7caa4645581a2d586a917e5b167285788c9eac520b32"; };
            Dynamic_Crosshair = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/ZcR9weSm/versions/CpaeqowJ/dynamiccrosshair-9.3%2B1.21.3-fabric.jar"; "sha256" = "02b876840ce4f082ec31083f1395250c83a3b2794227b7f1389b46909ddb8c4b"; };
            Enhanced_Block_Entities = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/OVuFYfre/versions/YokFoILZ/enhancedblockentities-0.11.3%2B1.21.4.jar"; "sha256" = "fdb311a6ba3280578e717d5efe4961e82f153cfe80c2ff3fd68e81cf5bc7607a"; };
            EntityCulling = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/NNAgCjsB/versions/W4olzuUc/entityculling-fabric-1.7.4-mc1.21.4.jar"; "sha256" = "2c0a03dca35337a607f71f55a2714ec890f5e650e19e9be1d7ea076e8df419a8"; };
            Fabric_API = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/bQZpGIz0/fabric-api-0.119.2%2B1.21.4.jar"; "sha256" = "0a7e37d1577217d764bc4a41fd144961ce6e4db1ef5e2b40ba5f280d4119ad0a"; };
            Fabric_Language_Kotlin = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/E4WyjCxJ/fabric-language-kotlin-1.13.2%2Bkotlin.2.1.20.jar"; "sha256" = "b316334e4190b63af42c599c13be14c46a58d0b7d93c53e06249c9ec29b22933"; };
            Falling_Leaves = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/WhbRG4iK/versions/TfbakxnW/fallingleaves-1.17.0%2B1.21.4.jar"; "sha256" = "547fec20a10d3cf272bb69dbf8d5beb4227c3ddca3da84d6214986792e98a1aa"; };
            FerriteCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/IPM0JlHd/ferritecore-7.1.1-fabric.jar"; "sha256" = "0dd5e9203552024e38e73a0f5b46a82eb66f0318b23289c6842b268663274a79"; };
            Forge_Config_API_Port = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/ohNO6lps/versions/lTrPTmMK/ForgeConfigAPIPort-v21.4.1-1.21.4-Fabric.jar"; "sha256" = "1e1f2e3f0f0385bc705c3cab9ef71a532ae22840bf69bf71d4aba58f59456dd6"; };
            Framework = pkgs.fetchurl { url = "https://mediafilez.forgecdn.net/files/6173/980/framework-fabric-1.21.4-0.10.3.jar"; "sha256" = "558f9e9faf596edcbc6954ade804a33c8d9b16776008d58be1e33692e603a708"; };
            GlitchCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/s3dmwKy5/versions/gBxcKjMS/GlitchCore-fabric-1.21.4-2.3.0.4.jar"; "sha256" = "ecec3dc01e33dae1e4676e5270b3fa067b8f5ce66f120d7d7bdd3c72ebe08fdc"; };
            Graves = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/kieAM9Us/versions/8l6YfN71/lullaby-graves-v2.1.4.jar"; "sha256" = "0e5954d43c86d25c3c1fdb941e7e2d3b92341ec119bb03462e00836b83247d37"; };
            Iceberg = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/5faXoLqX/versions/JQsyoArU/Iceberg-1.21.4-fabric-1.2.13.jar"; "sha256" = "08f3adebf46eb663fe991fb0fda28e5fc8f83378468ae8d9599ab7783473e072"; };
            Incendium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/ZVzW5oNS/versions/7mVvV9Th/Incendium_1.21.x_v5.4.4.jar"; "sha256" = "285a4f69fe2391f2175f7fc9316d727a39c79bdd214923c59284d569bce656f4"; };
            Inventory_Essentials = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Boon8xwi/versions/ZI6QIfgg/inventoryessentials-fabric-1.21.4-21.4.3.jar"; "sha256" = "7620f4b9072e48e50c539a7898172eb3ab45f1819fee55661d9cdbe0de0a74fd"; };
            Iris = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/YL57xq9U/versions/Ca054sTe/iris-fabric-1.8.8%2Bmc1.21.4.jar"; "sha256" = "70571b23d4de17ae380515fb4c9dadd82d96f7ec1b573553858a07bb80445da9"; };
            Jade = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/nvQzSEkH/versions/sSHUBFoq/Jade-1.21.4-Fabric-17.2.2.jar"; "sha256" = "085e71728de5101ddc6531f4a50eab4240fc28252703b3076a12826f98a84cb9"; };
            Journeymap = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/lfHFW1mp/versions/11kHuBXL/journeymap-fabric-1.21.4-6.0.0-beta.44.jar"; "sha256" = "ad671fc297f95827c0dd383d4b71a84c037a258bee9f84e11736c9b4ced13953"; };
            Just_Enough_Breeding = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9Pk89J3g/versions/g2dQj6YR/justenoughbreeding-fabric-1.21.4-1.5.0.jar"; "sha256" = "c4f1597c12f892f39139269500783c2e765d638a06e09b78dbf0616c593b8714"; };
            Just_Potion_Rings = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/6C3LNL9Q/versions/Pv4TlhT3/justpotionrings-fabric-1.21.4-v1.4.jar"; "sha256" = "f542f18c224859903897ca1866ec06c21e111dde9b77285b9d76814a4ea67792"; };
            Knowlogy_Book = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/V4OTaHaq/versions/vzD27bzJ/knowlogy-fabric-0.8.1-1.21.4.jar"; "sha256" = "174c944318ee520ffc61519ffdff1d5c9cf0a193be0edc967172f097ec066a6d"; };
            Krypton = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar"; "sha256" = "94f195819b24e5da64effdc9da15cdd84836cc75e8ff0fd098bab6bc2f49e3fe"; };
            LambDynamicLights = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/yBW8D80W/versions/Q9UNnRXZ/lambdynamiclights-4.1.0%2B1.21.4.jar"; "sha256" = "d569e31cd87b36dba57a6738d585aadbe868236e75b89101dda2c95b11d514d8"; };
            Lavender = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/D5h9NKNI/versions/Q986CZXM/lavender-0.1.15%2B1.21.4.jar"; "sha256" = "4e2079e15b96195b7e8b0309b7afe04bf81851f2b16c4787d1c905b4994875e1"; };
            Ledger = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/LVN9ygNV/versions/rTQMkMmp/ledger-1.3.7.jar"; "sha256" = "ccf5c908e71d707431a7d035736b114fc4331f3e9c8f7ba9e34d5d68d8c72afd"; };
            Legendary_Tooltips = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/atHH8NyV/versions/7xI8xla5/LegendaryTooltips-1.21.4-fabric-1.5.1.jar"; "sha256" = "5725030d92065f28f90dd5b9fe5fdb37e0a601f82ead16fff6f122846e94c2ac"; };
            Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/u8pHPXJl/lithium-fabric-0.15.3%2Bmc1.21.4.jar"; "sha256" = "153891e8d6988fedffa5098851a725a137c3e5ca04a89a8df409feb313623eb4"; };
            Lithostitched = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/XaDC71GB/versions/n1TiLJEh/lithostitched-fabric-1.21.4-1.4.5.jar"; "sha256" = "c802b99ed003818dad3268955faf73df58354f69a834e6fae5896070f23c80f1"; };
            Macaw_s_Biomes_O_Plenty = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Tanquv9C/versions/jYevgEeI/mcwbiomesoplenty-fabric-1.21.4-1.1.1.jar"; "sha256" = "692f546e741746295d87a8c83f2f770b700c0e18e1cf6e103760397508f2dff8"; };
            Macaw_s_Doors = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/kNxa8z3e/versions/UKkIyf5K/mcw-doors-1.1.2-mc1.21.4fabric.jar"; "sha256" = "fdae3023a3277cb07f9978292a48a6f8db50bd371e64903c58860d55bbb82d74"; };
            Macaw_s_Fences_and_Walls = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/GmwLse2I/versions/TwmTa64u/mcw-fences-1.2.0-1.21.4fabric.jar"; "sha256" = "98614aca71c0605fc7e896849f40b9da586e04f8f1e543fb52d181bb47721855"; };
            Macaw_s_Paintings = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/okE6QVAY/versions/rjN4KiqJ/mcw-paintings-1.0.5-1.21.4fabric.jar"; "sha256" = "f22f4188264fbddd88ff5389135a298edfb2294f40ef19526a7f2892a8e0ca2d"; };
            Macaw_s_Paths_and_Pavings = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VRLhWB91/versions/dxILwm8g/mcw-paths-1.1.0fabric-mc1.21.4.jar"; "sha256" = "69dd53d81ea97dac23777b37d25df5fedf88b784a6b60fbed9cf6e9622e16be5"; };
            Macaw_s_Stairs_and_Balconies = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/iP3wH1ha/versions/Pw40pkeV/mcw-stairs-1.0.1-1.21.4fabric.jar"; "sha256" = "6af996eb2f766eb64c651bebf0470236a1715f02edcb8985c53e040572cb0dd2"; };
            Macaw_s_Trapdoors = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/n2fvCDlM/versions/ghZIpxGJ/mcw-trapdoors-1.1.4-mc1.21.4fabric.jar"; "sha256" = "977b7aa4df5f0ffa470ec739044ee83c7dd434b81f93704b2d6d794c0aee0663"; };
            MidnightLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/codAaoxh/versions/owfXImvq/midnightlib-1.7.1-fabric%2B1.21.4.jar"; "sha256" = "ea8d881ca18158c521e5b9acaea1954d502f7ce3ff2046b75e1d7e1f5f5d1e5e"; };
            Mod_Menu = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/mOgUt4GM/versions/7iGb2ltH/modmenu-13.0.3.jar"; "sha256" = "6a50521e2bc11fa33f88973eb096995fd161bbbbab504a777ae7eadc51eebaf9"; };
            ModMenu_Badges_Lib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/eUw8l2Vi/versions/n5smDDrP/modmenu-badges-lib-2023.6.1.jar"; "sha256" = "12af314796682fb98e19105d91c58ae9798e3c19173410e0729b751477cc953d"; };
            Mouse_Tweaks = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/aC3cM3Vq/versions/m8rwZENW/MouseTweaks-fabric-mc1.21.3-2.27.jar"; "sha256" = "82aaa759bb702c5b958e1d8f9ae0935213e50a9588dce8be0cbfb5074121bc48"; };
            MrCrayfish_s_Furniture_Mod_Refurbished = pkgs.fetchurl { url = "https://mediafilez.forgecdn.net/files/6272/845/refurbished_furniture-fabric-1.21.4-1.0.12.jar"; "sha256" = "8b1dd609f2fc49a3232c1f187aaafb2b147fe17bfd9677c099dd10b531f102a9"; };
            Nameless_Trinkets = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/yGp7IenE/versions/pz6Vosfe/Nameless%20Trinkets-fabric-1.21.4-1.1.2.jar"; "sha256" = "29862ced4b4412a06609a7c704445046e4dd411aef00000b69261949d98b3a7a"; };
            Nature_s_Compass = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fPetb5Kh/versions/fF380mCq/NaturesCompass-1.21.4-2.2.8-fabric.jar"; "sha256" = "ccbbb5c4bd64eb7b62ff4c6355b678ca4b6d6abf2a2bc28efce7d6743e1d6e6f"; };
            Noisium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/9NHdQfkN/noisium-fabric-2.5.0%2Bmc1.21.4.jar"; "sha256" = "26649b7c5dc80da0b50627d1f1668a142a5a9ba9c7941590cd5af20d1e96beda"; };
            NotEnoughPots = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/KICpzgMG/versions/7rzkInGh/notenoughpots-1.21.4-fabric-1.3.jar"; "sha256" = "f121b2447b3ad9535309187485970f888e9659cf3ff82b7dab8ef8d5fbb4c76d"; };
            Nullscape = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/LPjGiSO4/versions/4qC7kfiC/Nullscape_1.21.x_v1.2.11.jar"; "sha256" = "511d549231a43fcac54a89b50ce2ebbb201d5a495a972e08701671157f778fb4"; };
            Paladin_s_Furniture = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/SISz7Qd3/versions/3ksIPiI7/paladin-furniture-mod-1.4.2-fabric-mc1.21.4.jar"; "sha256" = "ec07fe04fe8fb45dba3596a791156ed068a133d6a06635500abdbb88e9203ca5"; };
            Placeholder_API = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/eXts2L7r/versions/eeN3FuMY/placeholder-api-2.5.2%2B1.21.3.jar"; "sha256" = "d09cb209dac7e63d9b73cdf7da6f35da164720f0641c2d95ca14ec978b11cd32"; };
            PolyDecorations = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/5710VC7f/versions/dhJ5QuLH/polydecorations-0.6.0%2B1.21.4-rc3.jar"; "sha256" = "e590fd88fa837ad7beb86026318fc12df8a1c52ad4ef112de13af0c1b496026b"; };
            Polymer = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/xGdtZczs/versions/71wYlThU/polymer-bundled-0.11.8%2B1.21.4.jar"; "sha256" = "9eec7a31d18ac05eaf2ea439f2e9f4580b0f10e246fc90990d561e04e3776993"; };
            Recipe_Cooldown = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/7LEWYKTV/versions/oe5KEgWu/RecipeCooldown-1.0.0.jar"; "sha256" = "44d18ff65f42d7abc3103992e0611b8941ba0e8affdb65c7ee63d5ac230144d3"; };
            Roughly_Enough_Items = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/nfn13YXA/versions/9cWZy55a/RoughlyEnoughItems-18.0.804-fabric.jar"; "sha256" = "1c66f63fac1ac63c528e1ddd8d3ab7fc31b4ff1e1591ec98f4134456d1dfb796"; };
            Searchables = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fuuu3xnx/versions/Q98vtyfZ/Searchables-fabric-1.21.4-1.0.3.jar"; "sha256" = "80cbf2d53b8ff4629e84f45a818fa3a92dd17830d45207688f94da7efad7b21b"; };
            Simple_Voice_Chat = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/OkKjbu1V/voicechat-fabric-1.21.4-2.5.29.jar"; "sha256" = "1f56f67f7550fa1b4e43bc871222fe108e5465828b6910083c31e08bc93e820d"; };
            Sodium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/AANobbMI/versions/c3YkZvne/sodium-fabric-0.6.13%2Bmc1.21.4.jar"; "sha256" = "92b79623fc00f0f948005a0ae416cb42a51646f2423b4036e27e867e4001a47e"; };
            Sound_Physics_Remastered = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/qyVF9oeo/versions/YBQZz0DL/sound-physics-remastered-fabric-1.21.4-1.4.12.jar"; "sha256" = "421e2003ac12fad2f13dc2a055d40fe6922bae44fa2b0bfdb630e374bd9e72e0"; };
            Storage_Drawers = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/guitPqEi/versions/JLtRjyi8/Storage%20Drawers-fabric-1.21.4-15.0.1.jar"; "sha256" = "c0a286c96848c34b32cd046e362d5b98307b03cea1103b6555f360d861ccc1be"; };
            SuperMartijn642_s_Config_Library = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/LN9BxssP/versions/euSlaAtA/supermartijn642configlib-1.1.8-fabric-mc1.21.jar"; "sha256" = "63a29f2acf4be2c5ca89a81a046c1100111ad2865d9638f638e27ca161e7211c"; };
            SuperMartijn642_s_Core_Lib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/rOUBggPv/versions/ALUOfBQL/supermartijn642corelib-1.1.18a-fabric-mc1.21.4.jar"; "sha256" = "73ed46f2d76f0f6d760deb2ea43ff60c7033df0d68e0531a4fccdefc13a8959b"; };
            TSA_Decorations_Furniture = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/DLsxkJLC/versions/CuXLegeC/tsa-decorations-2.1.3%2B1.21.4.jar"; "sha256" = "c319dbe05dd649ff7008c581438b212cc6557a7b3369bcf80adf482b93fa6592"; };
            TerraBlender = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/kkmrDlKT/versions/BVtalJ0e/TerraBlender-fabric-1.21.4-4.3.0.2.jar"; "sha256" = "2bfc323b517ce5301644dcc66c774150e691cdf63f1f5a1786696ae56f2761d1"; };
            Terralith = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/MuJMtPGQ/Terralith_1.21.x_v2.5.8.jar"; "sha256" = "00333a130ac38b7b9ca93700098d5e02e0612bdc2d3522aada2f36e5600621bf"; };
            Tom_s_Simple_Storage_Mod = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/XZNI4Cpy/versions/HxyUAcZw/toms_storage_fabric-1.21.4-2.2.3.jar"; "sha256" = "3d57b4100fabd0e9ce934eb580f095b7055495446f664b18f7462c058ebc97e5"; };
            Tom_s_Storage_Knowlogy = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/WOgHMcEV/versions/U8kHL2Bk/tomsstorage_knowlogy-fabric-1.1.0-1.21.4.jar"; "sha256" = "37bd5fecf6292c72bf1a8f66c026856a2dd05dea6bbfad7643df45e936bd29fb"; };
            Traveler_s_Backpack = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/rlloIFEV/versions/A5imiRgQ/travelersbackpack-fabric-1.21.4-10.4.10.jar"; "sha256" = "201d869bd2a4e9bafd808db532d195717e30cb28b844bc6ffd6b53b4219422a4"; };
            Trinkets = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/G8hlgtEk/versions/87MTi6fA/trinkets-3.11.0-beta.1%2Bpolymerport.0.jar"; "sha256" = "5d5dd6efbfea2fe7f2de14a4936961cdee19799d5fad1451e150db382c5dad36"; };
            Vertigo = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/4LzgJp1j/versions/NMLr8giD/Vertigo-1.1.2-MC1.21.4.jar"; "sha256" = "1a2777299c5095734308e93b0c59b75b4479fd7969258a6c4ff0461492e2b6db"; };
            View_Distance_Fix = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/nxrXbh5K/versions/JHg6ZYop/viewdistancefix-fabric-1.21.4-1.0.2.jar"; "sha256" = "6564a12a4f8104c5889c08aa7a7ec85fbef93a948a5d3103c3ab04a43510cfd0"; };
            YetAnotherConfigLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/1eAoo2KR/versions/XeXZrziK/yet_another_config_lib_v3-3.6.6%2B1.21.4-fabric.jar"; "sha256" = "740d43a43f7dfae4a7debe2fd96a93a6c49f6b68eba4e89ef1de8706ce404fad"; };
            filament = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/yANxwqSX/versions/RdRMsrJz/filament-0.15.1%2B1.21.4.jar"; "sha256" = "f84c3a2f51a27342cee14ae1a49b7c10e6b62afa233ce52f816a9e3ffb973d7e"; };
            owo = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/ccKDOlHs/versions/kNCPPFb2/owo-lib-0.12.20%2B1.21.4.jar"; "sha256" = "699d283ded67d0617062289dab677d34e27feddccd0e2e7234f600dcacd27dd0"; };
            root_project_Prism = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/1OE8wbN0/versions/gFPeFgX2/Prism-1.21.4-fabric-1.0.10.jar"; "sha256" = "20797685676adb21682e311b2cc47c5af7b2afdf7fa4b504640827b02988edc1"; };
            spark = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/l6YH9Als/versions/X2sypdTL/spark-1.10.121-fabric.jar"; "sha256" = "135043024f1bd5806e85da8b2bdf15878c5598bf7daace5d130236ff009bb76f"; };
          }
        );
      };
    };
  };
}
