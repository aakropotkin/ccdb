{ stdenv, lib, autoreconfHook, jq, gawk }:
stdenv.mkDerivation {
  pname = "ccdb";
  src = builtins.path { path = ./.; };
  version = "0.1.0";
  nativeBuildInputs = [autoreconfHook];
  depsTargetTarget = [gawk];
  meta.license = lib.licenses.gpl3;
}
