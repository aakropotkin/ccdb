{ stdenv, lib, autoreconfHook, jq, bats, doCheck ? true }: let
  batsWith = bats.withLibraries (p: [
    p.bats-assert
    p.bats-file
    p.bats-support
  ]);
in stdenv.mkDerivation {
  pname = "ccdb";
  src = builtins.path { path = ./.; };
  version = "0.1.0";
  nativeBuildInputs = [autoreconfHook batsWith];
  buildInputs = [jq];
  inherit doCheck;
  meta.license = lib.licenses.gpl3;
}
