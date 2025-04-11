{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.droid-nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [ ./configuration.nix ];
    };

    packages.aarch64-linux.droid-nixos = self.nixosConfigurations.droid-nixos.config.system.build.toplevel;
  };
}
