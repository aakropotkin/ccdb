#! /usr/bin/env bash
# ============================================================================ #
#
#
#
# ---------------------------------------------------------------------------- #

#set -eu;
#set -o pipefail;


# ---------------------------------------------------------------------------- #

bats_load_library bats-support
bats_load_library bats-assert
bats_require_minimum_version '1.5.0'


# ---------------------------------------------------------------------------- #

# print_vars VARIABLE
# -------------------
# Print the value of VARIABLE.
print_var() {
  local var="$1";
  local val;
  eval val="\$$var";
  echo "$var='$val'";
}

# print_section_sep [CHAR]
# Print a character/string 80 times.
print_section_sep() {
  local _char="${1:--}";
  for _ in 0 1 2 3 4 5 6 7; do
    # Print 10 times.
    printf '%s' "$_char$_char$_char$_char$_char$_char$_char$_char$_char$_char";
  done;
  printf '\n';
}


# ---------------------------------------------------------------------------- #

# Programs
# --------

# A list of programs used by the test suite.
declare -a _bats_test_progs;
_bats_test_progs=();

# Print the value of each program.
print_progs() {
  print_section_sep;
  echo 'Programs:';
  for prog in "${_bats_test_progs[@]}"; do
    printf '  ';
    print_var "$prog";
  done
}

# Setup common programs as user overridable variables.
progs_setup() {
  if [[ -z "${_RAN_PROGS_SETUP:-}" ]]; then
    : "${MKDIR:=mkdir}";
    : "${MKDIR_P:=$MKDIR -p}";
    : "${REALPATH:=realpath}";
    : "${RM:=rm -f}";
    : "${TEST:=test}";
    : "${JQ:=jq}";
    : "${MKTEMP:=mktemp}";
    : "${GREP:=grep}";
    : "${SED:=sed}";
    : "${SORT:=sort}";
    : "${TR:=tr}";
    : "${WC:=wc}";
    : "${XARGS:=xargs}";
    : "${FIND:=find}";

    _bats_test_progs+=(
      MKDIR MKDIR_P REALPATH RM TEST TRUE FALSE JQ REALPATH MKTEMP GREP SED SORT
      TR WC XARGS FIND
    );

    for prog in "${_bats_test_progs[@]}"; do
      eval "export $prog";
    done

    print_progs >&3;
  fi
  export _RAN_PROGS_SETUP=1;
}


# ---------------------------------------------------------------------------- #

ccjs_setup() {
  if [[ -z "${_RAN_CCJS_SETUP:-}" ]]; then
    progs_setup;
    : "${CCJS:=$( $REALPATH "${BASH_SOURCE[0]%/*}/../main.bash"; )}";
    export CCJS;
    print_var CCJS;
  fi
  export _RAN_CCJS_SETUP=1;
}


# ---------------------------------------------------------------------------- #

# Run at the start of a `bats' invocation one or more files in this directory.
setup_suite() {
  # Greet the user.
  print_section_sep '=' >&3;
  echo "Initializing \`ccjs' Test Suite..." >&3;

  # Setup the things.
  progs_setup;
  ccjs_setup;

  # Print pre-test information.
  {
    print_section_sep;
    echo 'Starting tests...';
    echo '';
  } >&3;
}


# ---------------------------------------------------------------------------- #

# Common Hooks
# ------------

# Basic setup recommended for most tests.
# It is exposed as a function so that it can be appended by a file's own
# `setup' function(s).
common_test_setup() {
  mkdir -p "$BATS_TEST_TMPDIR";
  pushd "$BATS_TEST_TMPDIR" > /dev/null 2>&1||return;
  # Mark the project root directory.
  touch .root;
  refute "$TEST" -f compile_commands.json;
}

# Basic teardown recommended for use with `common_test_setup'.
common_teardown() {
  popd > /dev/null 2>&1||return;
  $RM -r "$BATS_TEST_TMPDIR";
}


# ---------------------------------------------------------------------------- #

# Set Default Hooks
# -----------------

setup() { common_test_setup; }
teardown() { common_teardown; }


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
