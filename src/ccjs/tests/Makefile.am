# ============================================================================ #
#
#
#
# ---------------------------------------------------------------------------- #

ACLOCAL_AMFLAGS = -I ../../../m4

SUBDIRS =


# ---------------------------------------------------------------------------- #

CCJS      ?= $(abs_builddir)/../bin/ccjs
CCJS_WRAP ?= $(abs_builddir)/../bin/ccjs-wrap


# ---------------------------------------------------------------------------- #

# TODO: `AC_PATH_PROGS' in `configure.ac'
BATS       ?= bats
BATSFLAGS  ?= --print-output-on-failure --verbose-run --timing
BATS_TESTS ?= $(wildcard *.bats)


# ---------------------------------------------------------------------------- #

check-bats: $(CCJS) $(CCJS_WRAP)
check-bats: setup_suite.bash
	CCJS=$(CCJS) CCJS_WRAP=$(CCJS_WRAP) $(BATS) $(BATSFLAGS) $(BATS_TESTS)

check-local: check-bats


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
