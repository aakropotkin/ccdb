{ stdenv, lib, autoreconfHook, jq, bats, doCheck ? false }: let
  batsWith = bats.withLibraries (p: [
    p.bats-assert
    p.bats-file
    p.bats-support
  ]);
in stdenv.mkDerivation {
  pname = "ccdb";
  src = builtins.path { 
    path = ./.; 
    filter = path: type: let
      bname = baseNameOf path;
      ignoredBNames = [
        "Makefile" 
	"configure" 
	"config.status" 
	"result" 
	"out"
        "autom4te.cache" 
	".github"
      ];
      bNameOkay = ! ( builtins.elem bname ignoredBNames );
      ignoredPatterns = [
        ".*~" ".*\\.log"
      ];
      test = patt: str: ( builtins.match patt str ) != null;
      patternsOkay = 
        builtins.all ( patt: ! ( test patt path ) ) ignoredPatterns;
    in bNameOkay && patternsOkay;
  };
  version = "0.1.0";
  nativeBuildInputs = [autoreconfHook batsWith];
  buildInputs = [jq];
  inherit doCheck;
  meta.license = lib.licenses.gpl3;
}
