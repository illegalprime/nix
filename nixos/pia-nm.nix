{ user, pia-nm, ... }:
{ config, pkgs, ... }:

with builtins;
with pkgs.lib.strings;

let
ca_cert = with pkgs; fetchurl {
  url = "https://www.privateinternetaccess.com/openvpn/ca.rsa.4096.crt";
  sha256 = "32e9b1d1433ea97614f2a14c6e358e3f57c0570cc9f6b2ee812699ba696c66ab";
};

servers = fromJSON (readFile ./pia-config.json);
in
{
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanager_openvpn
  ];

  environment.etc = foldl' (init: name_uuid:
    let
      uuid = name_uuid.snd;
      vpn_str = name: toLower (replaceStrings [" "] ["-"] name);
      server = servers."${name_uuid.fst}";
      cipher = "AES-256-CBC";
      auth = "SHA256";
      tcp = "no";
      port = if tcp == "yes" then 501 else 1197;
      user_only = if isNull user then "" else "permissions=user:${user.name}:;";
    in
    init // {
      "NetworkManager/system-connections/pia-${vpn_str server.name}" = {
        text = ''
          [connection]
          id=PIA - ${server.name}
          uuid=${uuid}
          type=vpn
          autoconnect=false
          ${user_only}

          [vpn]
          service-type=org.freedesktop.NetworkManager.openvpn
          username=${pia-nm.user}
          comp-lzo=yes
          remote=${server.dns}
          cipher=${cipher}
          auth=${auth}
          connection-type=password
          password-flags=1
          port=${toString port}
          proto-tcp=${tcp}
          ca=${ca_cert}

          [ipv4]
          method=auto
        '';
        mode = "600";
      };
    }) {} (pkgs.lib.lists.zipLists
      (filter (n: n != "info") (attrNames servers))
      [
        "453bcca9-2fa9-4335-95ba-cf48dc9fd5da"
        "37e6ded1-14a4-4783-9a40-c87f79b6f25c"
        "de27fcd5-bb12-4d16-aaa7-7726b9dae26d"
        "b50c9fa2-78d5-4eae-84f2-15d20690f007"
        "b4ad2ee9-fb9c-4744-9ff7-3ca25e7f6d0c"
        "5b6dfbd7-5fcc-49c5-99e8-312706dc7f40"
        "efb32d26-a8ac-4124-96d4-c75d5f1a80df"
        "5ec93444-32ca-4c12-a87a-3f39bf91622d"
        "a8f6761f-fd0a-4490-a28d-7f598814971c"
        "1c0e0825-fc5b-45d3-b62a-539a8e4ca2bf"
        "6929f731-3024-4995-8ee4-96b9d127e74d"
        "da986fba-6c16-4305-b512-a58c74e4eda9"
        "178f4635-327a-4b88-82d4-5f7481346e8a"
        "9c2e9fcd-b8b3-40db-854f-1cda9cd46683"
        "81ebbe60-6b1c-411f-966f-bcd3270447fa"
        "1c0ef394-63e1-46ff-b635-8adabb0f8a75"
        "300151c5-fcfb-4437-97bd-e84ea0b9524d"
        "7ccebe07-1e89-49fb-8c97-627dac0e2fb8"
        "d00e6001-6147-4af6-a079-a8ff90d5a2db"
        "7477b59d-aa54-4c04-9404-5bf0f7b55b5b"
        "4fb34a02-7ebc-4b6a-9ec6-e472a741acae"
        "f18e0697-f80d-4e3d-b9b1-6e3037fb3280"
        "ba19d88f-1fbb-4b9e-9783-860b6064834a"
        "ce84b42f-f79e-44e2-a886-972b3131c559"
        "408a6657-f2ad-4601-bcbc-4b2fbb139a2a"
        "0d35d074-2509-4bc5-95a6-99baefbf8482"
        "6b6985e6-b038-4ede-8d57-d599fcdbc52d"
        "d6e718fc-bec1-45e6-a922-c07eac3beb6c"
        "1c1d72ea-5193-47d7-b75c-55635e0f265d"
        "7e6d1d7d-40a6-49b9-83a7-2e43e20546e9"
        "ffc30c6e-3765-49ec-8679-93adfc2e7248"
        "ffe762a2-348d-457f-bb1e-98f0d0b29ccc"
        "fda098cf-95d8-42ec-896b-a2e8c35c3bfe"
        "94bc34d5-0da4-4b09-9fd1-86f3ee4d59e2"
        "839d385d-6995-4fde-809b-33de58f74b16"
        "7c4b09a2-42a1-432b-b310-2c62167b4348"
        "ee91c261-547b-4cb7-9c5f-ca5416f38517"
        "19373f44-c39a-4478-8658-2cc17a00d331"
        "c38509de-f16a-4457-914d-2281237923a9"
        "7d679e8c-1751-498d-9994-6819c205b995"
        "5687a03e-c7d9-4f3f-897c-6bd5d4cbc980"
        "ce38671c-51c4-46e2-b72a-2341160798ed"
        "f7f3a732-4fe1-4595-9fc9-0a9d4781c023"
        "f145f788-df21-48ce-a6b3-1f220d407316"
        "182ea840-ca1b-4a53-b0d0-ff1d50725c48"
        "7f02d5a5-4353-4af3-a329-92dd9176577a"
        "611ec388-8729-487d-9415-ca3b1b02a292"
        "e7943ec7-545c-4594-b24d-c30fe910dd3b"
        "d68a3a1b-ee3d-4790-a1ea-2875d93ab9e3"
        "8599b36e-5b9c-405f-b84b-d4fe554ee381"
      ]
    );
}
