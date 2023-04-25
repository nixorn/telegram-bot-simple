{
  description = "telegram-bot-simple";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.haskell-flake.flakeModule
      ];
      perSystem = { self', inputs', config, pkgs, lib, system, ... }: {
        haskellProjects.default = {
          packages.telegram-bot-simple.root = ./telegram-bot-simple;
          packages.telegram-bot-api.root = ./telegram-bot-api;
        };
      };
    };
}
