# see https://wiki.nixos.org/wiki/Mullvad_VPN
{
  relay_settings.normal = {
    location.only.location.country = "de";
    providers = "any";
    ownership = "any";
    wireguard_constraints = {
      ip_version = "any";
      allowed_ips = "any";
      use_multihop = false;
      entry_location.only.location.country = "de";
      entry_providers = "any";
      entry_ownership = "any";
    };
  };
  obfuscation_settings = {
    selected_obfuscation = "auto";
    udp2tcp.port = "any";
    shadowsocks.port = "any";
    wireguard_port.port = "any";
    lwo.port = "any";
  };
  custom_lists.custom_lists = [ ];
  api_access_methods = {
    direct = {
      id = "24a58c5f-1a12-4017-8107-10776fc0b994";
      name = "Direct";
      enabled = true;
      access_method.built_in = "direct";
    };
    mullvad_bridges = {
      id = "875776d4-d3f2-496c-b306-0f0143338a4b";
      name = "Mullvad Bridges";
      enabled = true;
      access_method.built_in = "bridge";
    };
    encrypted_dns_proxy = {
      id = "e5bc9fc7-3ce3-4d78-b339-fdd5d3106f78";
      name = "Encrypted DNS proxy";
      enabled = true;
      access_method.built_in = "encrypted_dns_proxy";
    };
    custom = [ ];
  };
  update_default_location = false;
  allow_lan = true;
  lockdown_mode = true;
  auto_connect = true;
  tunnel_options = {
    wireguard = {
      mtu = null;
      quantum_resistant = "on";
      daita = {
        enabled = false;
        use_multihop_if_necessary = false;
      };
      userspace = false;
      rotation_interval = null;
    };
    generic.enable_ipv6 = false;
    dns_options = {
      state = "default";
      default_options = {
        block_ads = true;
        block_trackers = true;
        block_malware = true;
        block_adult_content = true;
        block_gambling = true;
        block_social_media = true;
      };
      custom_options.addresses = [ ];
    };
  };
  relay_overrides = [ ];
  show_beta_releases = false;
  settings_version = 15;
  recents = [ { Singlehop.location.country = "de"; } ];
  rollout_threshold_seed = 3775179804;
}
