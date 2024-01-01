#! /usr/bin/env bats
# -*- mode: bats; -*-
# ============================================================================ #
#
# Tests basic `top-level' functionality of `ccjs'.
#
# ---------------------------------------------------------------------------- #

# bats file_tags=ccjs

load setup_suite.bash;

# ---------------------------------------------------------------------------- #

# Uses default `setup' and `teardown' defined in `setup_suite.bash'.


# ---------------------------------------------------------------------------- #

# bats test_tags=usage
@test "ccjs usage" {
  run "$CCJS" -u;
  assert_success;
  assert_output --partial 'USAGE:';

  run "$CCJS" --usage;
  assert_success;
  assert_output --partial 'USAGE:';
}


# ---------------------------------------------------------------------------- #

# bats test_tags=help
@test "ccjs help" {
  run "$CCJS" -h;
  assert_success;
  assert_output --partial 'USAGE:';

  run "$CCJS" --help;
  assert_success;
  assert_output --partial 'USAGE:';
}


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
