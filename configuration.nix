{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
  };

  boot.initrd.kernelModules = [
    "virtio-pci"
    "virtio-blk"
    "pci-host-generic"
  ];

  networking.hostName = "droid-nixos";

  fileSystems."/boot" = {
    device = "/dev/vda2";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  # Improve build speed
  documentation.nixos.enable = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # Run a service on pretending to be ttyd. Without some HTTPS server serving on
  # this port, the app kills your VM after some timeout.
  services.caddy = {
    enable = true;
    globalConfig = ''
      auto_https disable_redirects # No listening on 80
      skip_install_trust # No installing root certs
    '';
    virtualHosts.":7681".extraConfig = ''
      respond "Welcome to NixOS"
      tls internal {
        on_demand
      }
    '';
  };

  networking.firewall.enable = false;

  users.users.root.openssh.authorizedKeys.keys = [
    # FIXME: Change the key to your own
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILyu+hPasdL866eSgC/DgjxFY2swxSJAbI6mgKfPLztg"
  ];
}
