# -*- Autoconf -*-
# ============================================================================ #
#
# Process this file with autoconf to produce a configure script.
#
# ---------------------------------------------------------------------------- #

AC_PREREQ([2.71])
AC_INIT([ccdb], [0.1.0], [alex.ameen.tx@gmail.com])

AC_CONFIG_MACRO_DIRS([m4])
AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([foreign subdir-objects])

AC_CONFIG_SRCDIR([src/ccjs/ccjs])


# ---------------------------------------------------------------------------- #

# Checks for programs.

AC_PROG_CC
AC_PROG_AWK
AC_PROG_CXX
AC_PROG_CPP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
AC_PROG_GREP
AC_PROG_SED
AC_PROG_AUTOM4TE


# ---------------------------------------------------------------------------- #

AC_CONFIG_FILES([
  Makefile
  src/Makefile
  src/ccjs/Makefile
])
AC_OUTPUT


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
