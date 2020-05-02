{ pkgs ? import ./sources.nix {}, ocamlVersion ? "4_10" }:

with pkgs.ocamlPackages;

rec {
  aws = buildDunePackage {
    pname = "aws";
    version = "0.0.1-dev";

    src = lib.gitignoreSource ./..;

    useDune2 = true;

    propagatedBuildInputs = [
      calendar
      ezxmlm
      digestif
      uri
      atdgen
      yojson
      cmdliner
      ppxlib
      ocamlgraph
      piaf
      fmt
    ];

    doCheck = false;
  };
}

