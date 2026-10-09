{
  description = "ziglings dev shell: zig master + matching zls";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # 0.17.0-dev, newer than nixpkgs' zig_0_16. Dated tag keeps the lock
    # honest if master moves; bump deliberately.
    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zls is version-coupled to zig; nixpkgs only ships zls_0_16.
    zls = {
      url = "github:zigtools/zls";
    };
  };

  outputs =
    {
      nixpkgs,
      zig-overlay,
      zls,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = [
          zig-overlay.packages.${system}."master-2026-09-28"
          zls.packages.${system}.default
        ];
      };
    };
}
