#! /usr/bin/env bats
# -*- mode: bats; -*-
# ============================================================================ #
#
# Tests for `ccjs remove'.
#
# ---------------------------------------------------------------------------- #

# bats file_tags=ccjs

load setup_suite.bash;

# ---------------------------------------------------------------------------- #

# Uses default `setup' and `teardown' defined in `setup_suite.bash'.


# ---------------------------------------------------------------------------- #


# bats test_tags=usage,ccjs:remove
@test "ccjs remove usage" {
  run "$CCJS" remove -u;
  assert_success;
  assert_output --partial 'USAGE:';

  run "$CCJS" remove --usage;
  assert_success;
  assert_output --partial 'USAGE:';
}


# ---------------------------------------------------------------------------- #

# bats test_tags=help,ccjs:remove
@test "ccjs remove help" {
  run "$CCJS" remove -h;
  assert_success;
  assert_output --partial 'USAGE:';

  run "$CCJS" remove --help;
  assert_success;
  assert_output --partial 'USAGE:';
}


# ---------------------------------------------------------------------------- #

# bats test_tags=ccjs:remove,inline
@test "'ccjs remove' removes entry" {
  "$CCJS" add -i src/main.cc -- -Iinclude -Wall;

  run "$JQ" -r 'length' compile_commands.json;
  assert_success;
  assert_output '1';

  "$CCJS" remove -i src/main.cc;

  run "$JQ" -r 'length' compile_commands.json;
  assert_success;
  assert_output '0';
}


# ---------------------------------------------------------------------------- #

# bats test_tags=ccjs:remove,inline
@test "'ccjs remove' on non-existent entry is a no-op" {
  "$CCJS" add -i src/main.cc -- -Iinclude -Wall;

  run "$JQ" -r 'length' compile_commands.json;
  assert_success;
  assert_output '1';

  "$CCJS" remove -i src/foo.cc;

  run "$JQ" -r 'length' compile_commands.json;
  assert_success;
  assert_output '1';
}


# ---------------------------------------------------------------------------- #

# bats test_tags=ccjs:remove,inline,multiple
@test "'ccjs remove' takes multiple filenames" {
  "$CCJS" add -i src/main.cc -- -Iinclude -Wall;
  "$CCJS" add -i src/foo.cc -- -Iinclude -Wall;

  run "$JQ" -r 'length' compile_commands.json;
  assert_success;
  assert_output '2';

  "$CCJS" remove -i src/foo.cc src/main.cc;

  run "$JQ" -r 'length' compile_commands.json;
  assert_success;
  assert_output '0';
}


# ---------------------------------------------------------------------------- #

# bats test_tags=ccjs:remove
@test "'ccjs remove' without '-i' does not edit compile_commands.json" {
  "$CCJS" add -i src/main.cc -- -Iinclude -Wall;

  run "$JQ" -r 'length' compile_commands.json;
  assert_success;
  assert_output '1';

  unset output;
  run "$CCJS" remove src/main.cc;
  assert_success;
  assert_output '[]';

  # Do not modify
  run "$JQ" -r 'length' compile_commands.json;
  assert_success;
  assert_output '1';

}


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
