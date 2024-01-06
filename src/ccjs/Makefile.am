# ============================================================================ #
#
#
#
# ---------------------------------------------------------------------------- #

ACLOCAL_AMFLAGS = -I ../../m4

SUBDIRS =


# ---------------------------------------------------------------------------- #

bin_SCRIPTS = ccjs ccjs-wrap


# ---------------------------------------------------------------------------- #

# TODO: `AC_PATH_PROGS' in `configure.ac'
BATS       ?= bats
BATSFLAGS  ?= --print-output-on-failure --verbose-run --timing
BATS_TESTS ?= ./tests

check-bats: $(bin_SCRIPTS) tests/setup_suite.bash $(widcard tests/*.bats)
	CCJS=$(abs_builddir)/ccjs            \
	CCJS_WRAP=$(abs_builddir)/ccjs-wrap  \
	  $(BATS) $(BATSFLAGS) $(BATS_TESTS)

check-local: check-bats


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
