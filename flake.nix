# ============================================================================ #
#
#
#
# ---------------------------------------------------------------------------- #

{

# ---------------------------------------------------------------------------- #

  description = "Tools for managing build systems' configuration files";


# ---------------------------------------------------------------------------- #

  outputs = { nixpkgs, ... }: let

# ---------------------------------------------------------------------------- #

    eachSupportedSystemMap = let
      supportedSystems = [
        "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"
      ];
    in fn: let
      proc = system: { name = system; value = fn system; };
    in builtins.listToAttrs ( map proc supportedSystems );


# ---------------------------------------------------------------------------- #

    overlays.deps    = final: prev: {};
    overlays.ccdb    = final: prev: { ccdb = final.callPackage ./. {}; };
    overlays.default = nixpkgs.lib.composeExtensions overlays.deps
                                                     overlays.ccdb;


# ---------------------------------------------------------------------------- #

    nixosModules.ccdb = { nixpkgs.overlays = overlays.default; };
    nixosModules.default = nixosModules.ccdb;


# ---------------------------------------------------------------------------- #

  in {

    inherit overlays nixosModules;

    packages = eachSupportedSystemMap ( system: let
      pkgsFor = nixpkgs.legacyPackages.${system}.extend overlays.default;
    in {
      inherit (pkgsFor) ccdb;
      default = pkgsFor.ccdb;
    } );

  };  # End `outputs'


# ---------------------------------------------------------------------------- #

}


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
