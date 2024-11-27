{ lib, pkgs, config, ...}:

with lib; {
    options = 
    let
      typesLinks = types.attrsOf (types.attrsOf types.str);
      types = types // { linker = typesLinks; };
    in 
    {
        nix-link.enable = mkEnableOption "Enable nix-link";

        nix-link.links = mkOption {
            description = "Set of links to create";
            type = typesLinks;
            default = {};
        };

        nix-link.linkers = mkOption {
            description = "Set of linkers created by the user";
            type = types.attrsOf (types.submodule {
                dir = types.str;
                links = typesLinks;
            });
            default = {};
        };

        nix-link.meta = {
            description = "NixLink is a tool to manage symlinks in your NixOS system";
            longDescription = ''
                NixLink is a tool to manage symlinks in your NixOS system.
                It allows you to create symlinks in your system configuration
                to manage your dotfiles, scripts, and other files.
            '';
            license = lib.licenses.gpl3;
            maintainers = with lib.maintainers; [ ];
            platforms = lib.platforms.all;
            hydra = false;
        };
    };

    config = mkIf config.nix-link.enable {
        system.activationScripts.nix-link = ''
            echo "\nNixLink is enabled and running\n"
        '';
    };
}
