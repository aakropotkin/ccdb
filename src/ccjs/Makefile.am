# ============================================================================ #
#
#
#
# ---------------------------------------------------------------------------- #

bin_SCRIPTS = ccjs ccjs-wrap ccjs_add ccjs_remove


# ---------------------------------------------------------------------------- #

BATS       ?= bats
BATSFLAGS  ?= --print-output-on-failure --verbose-run --timing
BATS_TESTS ?= ./tests

check-bats: $(bin_SCRIPTS) tests/setup_suite.bash $(widcard tests/*.bats)
	CCJS=$(abs_builddir)/ccjs                \
	CCJS_ADD=$(abs_builddir)/ccjs_add        \
	CCJS_REMOVE=$(abs_builddir)/ccjs_remove  \
	CCJS_WRAP=$(abs_builddir)/ccjs-wrap      \
	  $(BATS) $(BATSFLAGS) $(BATS_TESTS)

check-local: check-bats


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
