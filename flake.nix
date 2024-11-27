{
    description = "NixLink is a tool to manage symlinks in your NixOS system";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
        nix-link = import ./default.nix;
    in 
    {
        nixosModules.nix-link = nix-link;
    };
}
