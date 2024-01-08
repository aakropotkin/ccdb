#! /usr/bin/env bash
# ============================================================================ #
#
# Provides a wrapper around `mktemp' which automatically cleans files and
# directories when the program exits.
#
# ---------------------------------------------------------------------------- #

# If this file has been run already skip it.
if [[ "${__ccdb_SOURCED_MKTMP_AUTO:-0}" != '0' ]]; then return 0; fi


# ---------------------------------------------------------------------------- #

# @BEGIN_INJECT_UTILS@
: "${MKTEMP:=mktemp}";
: "${RM:=rm}";
# @END_INJECT_UTILS@


# ---------------------------------------------------------------------------- #

# Stash current options to be restored later.
__ccdb_OLD_OPTS="$( set +o; )";
set -eu;
set -o pipefail;


# ---------------------------------------------------------------------------- #

# `:' Separated list of files to remove on exit.
: "${__ccdb_TMPFILES:=}";
# `:' Separated list of directories to remove on exit.
: "${__ccdb_TMPDIRS:=}";
export __ccdb_TMPFILES __ccdb_TMPDIRS;


# ---------------------------------------------------------------------------- #

# mktmp_auto [ARGS...]
# --------------------
# Wraps `mktemp' with automatic file/directory cleanup.
mktmp_auto() {
  local _file;
  _file="$( $MKTEMP "$@" )";
  case " $* " in
    *\ -d\ *|*\ --directory\ *)
      __ccdb_TMPDIRS="${__ccdb_TMPDIRS:+$__ccdb_TMPDIRS:}$_file";
    ;;
    *) __ccdb_TMPFILES="${__ccdb_TMPFILES:+$__ccdb_TMPFILES:}$_file"; ;;
  esac
  echo "$_file";
}
export -f mktmp_auto;


# ---------------------------------------------------------------------------- #

# Removes temporary files
_ccdb_cleanup() {
  declare -a _targets;
  IFS=':' read -ra _targets <<< "$__ccdb_TMPFILES";
  if [[ -n "${_targets[*]}" ]]; then $RM -f "${_targets[@]}"; fi
  IFS=':' read -ra _targets <<< "$__ccdb_TMPDIRS";
  if [[ -n "${_targets[*]}" ]]; then $RM -rf "${_targets[@]}"; fi
}
export -f _ccdb_cleanup;

# ---------------------------------------------------------------------------- #

# Runs `_ccdb_cleanup' on exit.
__ccdb_EXIT_STATUS=0;
trap '__ccdb_EXIT_STATUS="$?"; _ccdb_cleanup; exit "$__ccdb_EXIT_STATUS";'  \
     HUP TERM INT QUIT EXIT;


# ---------------------------------------------------------------------------- #

# Restore options.
eval "$__ccdb_OLD_OPTS";
unset __ccdb_OLD_OPTS;

# Mark this file as having been sourced to avoid rerunning it.
export __ccdb_SOURCED_MKTMP_AUTO=1;


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
