{
  description = "My beloved first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {

      homeConfigurations."rafael" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./hosts/rafael/home.nix
        ];

      };

      nixosConfigurations = {
        rafael = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/rafael/configuration.nix
          ];
        };
      };

      devShells.${system}.rust =
        pkgs.mkShell
          {
            buildInputs = with pkgs; [
              neovim
              rustc
              cargo
              libgcc
            ];
          };
    };
}
