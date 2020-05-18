{ ocamlVersion ? "4_10" }:

let
  # overlays = /Users/anmonteiro/Documents/github/nix-overlays;
  overlays =
    builtins.fetchTarball
      https://github.com/anmonteiro/nix-overlays/archive/964a4cb.tar.gz;

in

  import "${overlays}/sources.nix" {
    overlays = [
      (import overlays)
      (self: super: {
        ocamlPackages = super.ocaml-ng."ocamlPackages_${ocamlVersion}".overrideScope'
            (super.callPackage "${overlays}/ocaml" {});
      })
    ];
  }
