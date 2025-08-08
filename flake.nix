{

  description = "Amoeba's config";

  inputs = { #some git repos (z.B. nixpkgs)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; #NixOS known where nixpkgs are, so I could also put just "nixpkgs/nixos-25.05"
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };    

    #momoi-say.url  = "github:haruki-nikaidou/momoisay-rs";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: #specifying actual nix-os System we want to build
    let #read like Haskell
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      #momoiSay = momoi-say.packages.${system}.momoisay;
    in {
      nixosConfigurations = {
        amoeba = lib.nixosSystem {
          specialArgs = { inherit inputs system; }; #<=> system = system

          modules = [ 
            ./configuration.nix          

            #Add extra settings here (inside modules):
            #{  
            #  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            #    "discord"
            #  ]; #closes UnfreePkgs
            #} #closes extra settings

          ]; #closes modules

        };
      };
      homeConfigurations = {
        amoeba = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            #momoiSay

          ];
        };
      };

    };

}
