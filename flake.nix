{
  description = "NixOS systems and tools";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Non-flakes
    # nvim-conform.url = "github:stevearc/conform.nvim/v5.2.1";
    # nvim-conform.flake = false;
    # nvim-treesitter.url = "github:nvim-treesitter/nvim-treesitter/v0.9.1";
    # nvim-treesitter.flake = false;
    # vim-copilot.url = "github:github/copilot.vim/v1.11.1";
    # vim-copilot.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: let
  
    mkSystem = import ./lib/mksystem.nix {
      # inherit overlays nixpkgs inputs;
      inherit nixpkgs inputs;
    };
  in {
    nixosConfigurations.vm-aarch64 = mkSystem "vm-aarch64" {
      system = "aarch64-linux";
      user   = "xavier";
    };

    darwinConfigurations.macbook-pro-m1 = mkSystem "macbook-pro-m1" {
      system = "aarch64-darwin";
      user   = "xavier";
      darwin = true;
    };
  };
}
